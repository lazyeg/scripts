<!--
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2025-03-18 11:38:28
 * @LastEditors: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 * @LastEditTime: 2025-03-20 11:35:26
 * @FilePath: /gcp/README.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
## 目录
1. [安装与配置 Bash、Git 和 Kubectl 自动补全](#安裝与配置-bash-git-和-kubectl-自動補全)
2. [GCP Kubernetes 集群管理脚本](#gcp-kubernetes-集群管理脚本)
3. [使用 `.bashrc` 和 `.bash_profile` 配置 GCP 和 Kubernetes](#使用-bashrc-和-bash_profile-配置-gcp-和-kubernetes)
4. [Github Repo "Scripts"](#github-repo-scripts)
5. [SSH 脚本](#ssh-脚本)

---
# 安裝与配置 bash git 和 kubectl 自動補全
## Setup Instructions for Kubectl and Google Cloud SDK with Bash Completion

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

   Download Google Cloud SDK

   ```bash
   wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz
   ```

   Set as home directory

   ```
   ~/
   ```

   Add the following line to your `~/.bash_profile` to enable completion for Google Cloud SDK:

   ```bash
   echo 'source ~/google-cloud-sdk/completion.bash.inc' >> ~/.bash_profile
   ```

   Then reload your profile:

   ```bash
   source ~/.bash_profile
   ```

   Install kubectl

   ```bash
   gcloud components install kubectl
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

   or the following line to the file

   ```
   /opt/homebrew/opt/bash/bin/bash
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
# GCP Kubernetes 集群管理脚本
## GCP Kubernetes Cluster Management Script

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
# 使用 .bashrc 和 .bash_profile 配置 GCP 和 Kubernetes

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
```
# Github Repo "Scripts"

這個 repository 包含用於配置 bash 環境的腳本和配置文件，適用於 macOS（或其他使用 bash 的系統）。主要功能包括 SSH 金鑰生成、SSH 連接以及 bash 配置的自動化設置。

## 內容
- `.bashrc`: bash 的運行時配置文件
- `.bash_profile`: bash 的登錄配置文件
- `generate-ssh-key.sh`: 生成 SSH 金鑰的腳本
- `ssh-connect.sh`: 簡化 SSH 連接的腳本
- `install-bash-config.sh`: 安裝和配置腳本

## 安裝與使用

### 前置條件
- 安裝了 Git
- 使用 bash 作為 shell（確認：`echo $SHELL` 應輸出 `/bin/bash`）

### 步驟
1. **Clone Repository**
   ```bash
   git clone https://github.com/lazyeg/scripts.git ~/scripts
   ```

2. **運行安裝腳本**
   ```bash
   cd ~/scripts
   chmod +x install-bash-config.sh
   ./install-bash-config.sh
   ```

### 腳本功能
- 如果 ~/scripts 不存在，會自動 clone 本 repo
- 如果 ~/scripts 已存在，會執行 git pull 更新
- 備份現有的 ~/.bashrc 和 ~/.bash_profile（若存在）
- 將 repo 中的 .bashrc 和 .bash_profile 透過軟連結設置到 ~/
- 為所有 .sh 腳本設置執行權限
- 重新載入 bash 配置

# SSH Scripts

這些腳本提供了簡單的 SSH 連接和 SSH 密鑰生成的功能，適用於多個平台，並可用於管理遠程伺服器。

## 文件結構

### 說明：

1. **腳本解釋**：在 `README.md` 中加入了 `ssh-connect.sh` 腳本的詳細內容和解釋。
2. **使用方法**：描述了如何使用腳本並提供了具體的命令範例。
3. **簡化配置**：介紹了如何將別名配置到 `.bashrc` 或 `.zshrc` 中，以簡化腳本使用。
4. **注意事項**：提到一些使用腳本的常見注意事項，確保使用者順利運行。

## 功能

**生成 SSH 密鑰對**：這個腳本會生成一對 RSA 4096 位的 SSH 密鑰對，並將私鑰和公鑰保存在指定位置。

### 使用方法

```bash

~/scripts/generate-ssh-key.sh <key_name>

```

**ssh-connect.sh 腳本可以用來通過 SSH 連接到遠程伺服器。腳本的內容如下**：

```bash
~/scripts/ssh-connect.sh
```

### 使用方法

```
ss <ip_address>
```
