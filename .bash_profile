if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
#golang env


export CLICOLOR='true'
export LSCOLORS="gxfxcxdxcxegedabagacad"
# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

source <(kubectl completion bash)

complete -o default -F __start_kubectl k
# kubect
if [ -f /opt/homebrew/etc/bash_completion.d/kubectl ]; then
    source /opt/homebrew/etc/bash_completion.d/kubectl
fi
# git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# docker
if [ -f /opt/homebrew/etc/bash_completion.d/docker ]; then
    source /opt/homebrew/etc/bash_completion.d/docker
fi
# helm
if [ -f /opt/homebrew/etc/bash_completion.d/helm ]; then
    source /opt/homebrew/etc/bash_completion.d/helm
fi

[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/michael.hung/google-cloud-sdk/path.bash.inc' ]; then . '/Users/michael.hung/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/michael.hung/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/michael.hung/google-cloud-sdk/completion.bash.inc'; fi
source /Users/michael.hung/google-cloud-sdk/completion.bash.inc

complete -C /opt/homebrew/bin/terraform terraform
