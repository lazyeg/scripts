#!/bin/bash
###
 # @Author: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 # @Date: 2025-03-19 17:21:29
 # @LastEditors: michael.hung michael.hung@michaelhungdeMacBook-Pro.local
 # @LastEditTime: 2025-03-19 17:31:19
 # @FilePath: /gcp/ssh-connect.sh
 # @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
### 

# 默認使用者名稱，可以根據需要修改
USER=${USER:-devops}

# 檢查是否傳入了IP地址
if [ $# -lt 1 ]; then
  echo "Usage: $0 <IP>"
  exit 1
fi

IP=$1

