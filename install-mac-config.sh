#!/bin/bash

# Exit on any error
set -e

# Colors for output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Define home directory explicitly
HOME_DIR="$HOME"
SCRIPT_DIR="$HOME/scripts"

echo -e "${GREEN}Starting installation and configuration from $SCRIPT_DIR...${NC}"

# Step 1: Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Step 2: Install Bash and Git using Homebrew
echo "Installing Bash and Git..."
brew install bash
brew install git

# Step 3: Install bash-completion and docker-completion
echo "Installing bash-completion and docker-completion..."
brew install bash-completion
brew install docker-completion

# Step 4: Set up Google Cloud SDK in home directory
echo "Downloading and installing Google Cloud SDK to $HOME_DIR..."
cd "$HOME_DIR"
wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz -P "$HOME_DIR"
tar -zxvf "$HOME_DIR/google-cloud-cli-darwin-arm.tar.gz" -C "$HOME_DIR"
"$HOME_DIR/google-cloud-sdk/install.sh" --quiet

# Step 5: Add Google Cloud SDK completion to ~/.bash_profile
echo "Configuring Google Cloud SDK auto-completion..."
echo "source $HOME_DIR/google-cloud-sdk/completion.bash.inc" >> "$HOME_DIR/.bash_profile"

# Step 6: Install kubectl and gke-gcloud-auth-plugin
echo "Installing kubectl and gke-gcloud-auth-plugin via Google Cloud SDK..."
gcloud components install kubectl --quiet
gcloud components install gke-gcloud-auth-plugin --quiet

# Step 7: Configure GKE auth plugin
echo "Setting up GKE authentication plugin..."
echo 'export USE_GKE_GCLOUD_AUTH_PLUGIN=True' >> "$HOME_DIR/.bash_profile"

# Step 8: Add new Bash to /etc/shells
BASH_PATH="/opt/homebrew/opt/bash/bin/bash"  # For Apple Silicon Macs
if [ ! -f "$BASH_PATH" ]; then
    BASH_PATH="/usr/local/Cellar/bash/5.2.37/bin/bash"  # Fallback for Intel Macs
fi

echo "Adding new Bash to /etc/shells..."
if ! grep -Fxq "$BASH_PATH" /etc/shells; then
    echo "$BASH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

# Step 9: Change default shell to new Bash
echo "Changing default shell to new Bash..."
chsh -s "$BASH_PATH"

# Step 10: Reload shell configuration
echo "Reloading ~/.bash_profile..."
source "$HOME_DIR/.bash_profile"

# Step 11: Test kubectl auto-completion
echo -e "${GREEN}Setup complete! Testing kubectl auto-completion...${NC}"
echo "Type 'kubectl ' and press Tab to test. If it works, you'll see command suggestions."
echo "To connect to a GKE cluster, run: gcloud container clusters get-credentials YOUR_CLUSTER_NAME --region YOUR_REGION --project YOUR_PROJECT_ID"

# Final message
echo -e "${GREEN}All done! Please restart your terminal or open a new tab to ensure all changes take effect.${NC}"