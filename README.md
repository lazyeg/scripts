<!--
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2025-03-18 11:38:28
 * @LastEditors: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 * @LastEditTime: 2025-03-18 13:09:30
 * @FilePath: /gcp/README.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
# Setup Instructions for Kubectl and Google Cloud SDK with Bash Completion

### Steps to Install and Configure Bash, Git, and Kubectl Auto-Completion with Google Cloud SDK

1. **Install Bash and Git using Homebrew**

   First, install `bash` and `git` using Homebrew:
   ```bash
   brew install bash
   brew install git
   ```

2. **Install Bash Completion and Docker Completion**

   Install `bash-completion` and `docker-completion` to enable auto-completion for various tools:
   ```bash
   brew install bash-completion
   brew install docker-completion
   ```

3. **Add Google Cloud SDK and Kubectl Auto-Completion**

   Since `kubectl` is installed via the Google Cloud SDK located at `/Users/michael.hung/google-cloud-sdk/bin/kubectl`, you need to source the completion script for Google Cloud SDK.

   Add the following line to your `~/.bash_profile` to enable completion for Google Cloud SDK:
   ```bash
   echo 'source /Users/michael.hung/google-cloud-sdk/completion.bash.inc' >> ~/.bash_profile
   ```

   Then reload your profile:
   ```bash
   source ~/.bash_profile
   ```

4. **Add New Bash to Available Shells**

   Edit the `/etc/shells` file to include the newly installed Bash (version 5.2.37) so that you can set it as your default shell.

   Open the `/etc/shells` file with superuser privileges:
   ```bash
   sudo vi /etc/shells
   ```

   Add the following line to the file:
   ```
   /usr/local/Cellar/bash/5.2.37/bin/bash
   ```

5. **Change Default Shell**

   After updating `/etc/shells`, change your default shell to the new version of Bash:
   ```bash
   chsh -s /usr/local/Cellar/bash/5.2.37/bin/bash
   ```

6. **Test Auto-Completion**

   To ensure that everything is set up correctly, test the auto-completion for `kubectl`:
   ```bash
   kubectl <Tab>
   ```

   If everything is configured correctly, you should see the auto-completion options for `kubectl`.


# GCP Kubernetes Cluster Management Script

This script helps you manage and interact with Kubernetes clusters on Google Cloud Platform (GCP). It allows you to set the project, select the cluster, configure `gcloud` settings, and perform various operations such as listing instances or accessing Kubernetes contexts.

## Features

- Set GCP project and activate configurations.
- Switch between Kubernetes clusters.
- List available Kubernetes contexts.
- SSH into instances.
- Check the status of GCP configurations.

## Prerequisites

Make sure you have the following tools installed:

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

Also, ensure that your Google Cloud project is set up with the necessary IAM permissions for managing Kubernetes Engine clusters, instances, and configurations.

## Usage

### General Command Format

```bash
./gcp.k8.sh [project_name] [cluster_name] [zone] [list | get-contexts | ssh | status]
```

# Using `.bashrc` and `.bash_profile` for GCP and Kubernetes Configuration

To streamline working with Google Cloud and Kubernetes, all you need are the `.bashrc` and `.bash_profile` files. These files allow you to set environment variables, aliases, and functions that make managing GCP and Kubernetes easier.

## 1. **Setting Up `.bashrc`**

The `.bashrc` file is used for interactive non-login shells and is ideal for setting up environment variables, aliases, and functions that will be available for every new terminal session.

### Example `.bashrc` Configuration:

```bash
# Google Cloud and Kubernetes environment variables
export GCP_PROJECT_ID="your-project-id"
export GCP_CLUSTER_NAME="your-cluster-name"
export GCP_ZONE="your-zone"

# kubectl alias to make it easier to interact with clusters
alias k='kubectl'
alias gcloud='gcloud --project $GCP_PROJECT_ID'

# GCP authentication (if needed)
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/your-credentials-file.json"

# Function to easily switch GCP project and get cluster credentials
function set_gcp_project_cluster() {
    gcloud config set project $GCP_PROJECT_ID
    gcloud container clusters get-credentials $GCP_CLUSTER_NAME --zone $GCP_ZONE --project $GCP_PROJECT_ID
    echo "Switched to project $GCP_PROJECT_ID and cluster $GCP_CLUSTER_NAME"
}


