#!/bin/bash
###
 # @Author: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 # @Date: 2025-03-20 10:50:21
 # @LastEditors: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 # @LastEditTime: 2025-03-20 10:55:42
 # @FilePath: /scripts/install-bash-config.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%A
###

# 定義變數
HOME_DIR="$HOME"
SCRIPTS_DIR="$HOME/scripts"
REPO_URL="https://github.com/lazyeg/scripts.git"

# 獲取腳本當前所在目錄
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. 檢查並創建或更新 scripts 目錄
echo "開始設置..."
if [ ! -d "$SCRIPTS_DIR" ]; then
    echo "Clone repository 到 ~/scripts"
    git clone "$REPO_URL" "$SCRIPTS_DIR"
elif [ -d "$SCRIPTS_DIR/.git" ]; then
    echo "scripts 目錄已存在且是 git repo，更新它"
    cd "$SCRIPTS_DIR" && git pull
else
    echo "錯誤：~/scripts 已存在但不是 git 倉庫，請手動檢查並移除或備份後重試"
    exit 1
fi

# 2. 備份原有的 .bashrc 和 .bash_profile
if [ -f "$HOME_DIR/.bashrc" ]; then
    echo "備份原有的 .bashrc"
    mv "$HOME_DIR/.bashrc" "$HOME_DIR/.bashrc.bak"
fi

if [ -f "$HOME_DIR/.bash_profile" ]; then
    echo "備份原有的 .bash_profile"
    mv "$HOME_DIR/.bash_profile" "$HOME_DIR/.bash_profile.bak"
fi

# 3. 創建軟連結
echo "創建軟連結..."
ln -sf "$SCRIPTS_DIR/.bashrc" "$HOME_DIR/.bashrc"
ln -sf "$SCRIPTS_DIR/.bash_profile" "$HOME_DIR/.bash_profile"

# 4. 設置執行權限給 shell 腳本
echo "設置腳本權限..."
chmod +x "$SCRIPTS_DIR/generate-ssh-key.sh"
chmod +x "$SCRIPTS_DIR/ssh-connect.sh"
chmod +x "$SCRIPTS_DIR/install-bash-config.sh"  # 確保自身也有執行權限

# 5. 重新載入 bash 配置
echo "重新載入配置..."
source "$HOME_DIR/.bash_profile"

echo "設置完成！"
echo "你可以檢查以下文件："
echo "- $HOME_DIR/.bashrc (連結到 $SCRIPTS_DIR/.bashrc)"
echo "- $HOME_DIR/.bash_profile (連結到 $SCRIPTS_DIR/.bash_profile)"