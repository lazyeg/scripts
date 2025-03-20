<!--
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2025-03-18 11:38:28
 * @LastEditors: michael.hung hon0612@gmail.com
 * @LastEditTime: 2025-03-20 13:39:08
 * @FilePath: /gcp/README.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
## 目錄
-  [安装与配置 Bash、Git 和 Kubectl 自动补全](#安裝與配置-bash-git-和-kubectl-自動補全)
-  [Github Repo "Scripts"](#github-repo-scripts)

---
# 安裝與配置 bash git 和 kubectl 自動補全
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

   ```
   echo 'source ~/google-cloud-sdk/completion.bash.inc' >> ~/.bash_profile
   ```

   Then reload your profile:

   ```
   source ~/.bash_profile
   ```

   Install kubectl

   ```
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


# Github Repo "Scripts"

這個 repository 包含用於配置 bash 環境的腳本和配置文件，適用於 macOS（或其他使用 bash 的系統）。主要功能包括 SSH 金鑰生成、SSH 連接以及 bash 配置的自動化設置。

## 內容
- `.bashrc`: bash 的運行時配置文件
- `.bash_profile`: bash 的登錄配置文件
- `generate-ssh-key.sh`: 生成 SSH 金鑰的腳本
- `ssh-connect.sh`: 簡化 SSH 連接的腳本
- `install-bash-config.sh`: 安裝和配置腳本
- `gcp.k8.sh`: GCP Kubernetes 集群管理脚本
  - Set GCP project and activate configurations.
  - Switch between Kubernetes clusters.
  - List available Kubernetes contexts.
  - SSH into instances.
  - Check the status of GCP configurations.
## Usage

### General Command Format



## 安裝與使用

### 前置條件
- 安裝了 Git
- 使用 bash 作為 shell（確認：`echo $SHELL` 應輸出 `/bin/bash`）
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### 步驟
1. **Clone Repository**
   ```
   git clone https://github.com/lazyeg/scripts.git ~/scripts
   ```

2. **修改 shell 權限**

   ```bash
   cd ~/scripts 
   chmod +x *.sh
   ```

3. **運行 install-bash-config.sh 安裝腳本**
   ```bash
   cd ~/scripts
   ./install-bash-config.sh
   ```

4. **運行 generate-ssh-key.sh 安裝腳本**

   ```bash
   cd ~/scripts
   chmod +x generate-ssh-key.sh
   generate-ssh-key.sh [username].sshkey
   ```

## Usage

### General Command Format

`gcp.k8s.sh`

```bash
./gcp.k8.sh [project_name] [cluster_name] [zone] [list | get-contexts | ssh | status]
```
`generate-ssh-key.sh`

```bash
./generate-ssh-key.sh <key_name>.sshkey
```

`ssh-connect.sh`

```
 ./ssh-connect.sh <IP>
```

### install-bash-config.sh 腳本功能

- 如果 ~/scripts 不存在，會自動 clone 本 repo
- 如果 ~/scripts 已存在，會執行 git pull 更新
- 備份現有的 ~/.bashrc 和 ~/.bash_profile（若存在）
- 將 repo 中的 .bashrc 和 .bash_profile 透過軟連結設置到 ~/
- 為所有 .sh 腳本設置執行權限
- 重新載入 bash 配置

### generate-ssh-key.sh 腳本功能
- 這個腳本會生成一對 RSA 4096 位的 SSH 密鑰對，並將私鑰和公鑰保存在指定位置

### ssh-connect.sh 腳本功能

- 腳本可以用來通過 SSH 連接到遠程伺服器
- 默認使用者名稱，可以根據需要修改 `USER=${USER:-michael.hung}`
- 搭配 `generate-ssh-key.sh` 使用

