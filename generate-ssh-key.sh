#!/bin/bash
###
 # @Author: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 # @Date: 2025-03-19 17:33:51
 # @LastEditors: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 # @LastEditTime: 2025-03-20 09:38:18
 # @FilePath: /gcp/generate-ssh-key.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
### 

# 檢查是否指定了 SSH 密鑰的存儲位置 記得 key name 加 .sshkey
if [ -z "$1" ]; then
  echo "Usage: $0 <key_name>"
  exit 1
fi

KEY_NAME=$1
KEY_PATH=~/.ssh/$KEY_NAME

# 檢查密鑰是否已經存在
if [ -f "$KEY_PATH" ]; then
  echo "Key already exists at $KEY_PATH. Please choose a different name or delete the existing key."
  exit 1
fi

# 生成 SSH 密鑰對
echo "Generating SSH key pair at $KEY_PATH..."
ssh-keygen -t rsa -b 4096 -f "$KEY_PATH" -N ""

# 顯示生成的公鑰位置
echo "SSH key pair generated successfully!"
echo "Public key: $KEY_PATH.pub"
