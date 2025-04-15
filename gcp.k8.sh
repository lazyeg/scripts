#!/bin/bash
# Program:
#   This script accepts project_name, cluster_name, zone, and other commands.
# History:
# 2015/07/17    VBird    First release
#!/bin/bash

# 定義字體與顏色
FONT_BOLD='\033[1m'
COLOR_OKGREEN='\033[92m'
COLOR_END='\033[0m'

# 專案資料
PROJECT_ANB1166="anb1166"
PROJECT_AOLONG="mh-aolong-402510"
PROJECT_LETRON="mh-letron"
PROJECT_LETRON_UAT="mh-letron-uat"
PROJECT_BBG="mh-other-sportcms-bbg"
PROJECT_VOGUE="mh-vogue"
PROJECT_SPORTSCMS_HB="sportscms-hb"

# 輸出說明信息
echo -e "${COLOR_OKGREEN}This k8s script will print your selection!${COLOR_END}\n"
profiles_message=$FONT_BOLD"Usage ${0} [project_name] [cluster_name] [zone] [list | get-contexts | ssh | status]"$COLOR_END

# 檢查並創建 GCP 配置
check_or_create_configuration() {
      config_name=$1
      existing_config=$(gcloud config configurations list --format="value(name)" | grep -w $config_name)

      if [ -z "$existing_config" ]; then
            echo "Configuration $config_name does not exist. Creating..."
            gcloud config configurations create $config_name || {
                  echo "Failed to create configuration $config_name"
                  exit 1
            }
      else
            echo "Configuration $config_name already exists."
      fi
}

# 檢查並設置帳號
check_and_set_account() {
      account_email=$(gcloud config list account --format="value(core.account)")
      if [ -z "$account_email" ]; then
            echo "No active account found. Please log in."
            gcloud auth login || {
                  echo "Failed to log in"
                  exit 1
            }
      else
            echo "Active account is $account_email"
      fi
}

# 在這裡調用檢查帳號的函數
check_and_set_account

# 根據參數選擇專案
case ${1} in
"mh-letron")
      echo "Your choice is mh-letron"
      PROJECT_ID=$PROJECT_LETRON
      check_or_create_configuration mh-letron
      gcloud config set project $PROJECT_ID
      gcloud config configurations activate mh-letron || {
            echo "Failed to activate configuration mh-letron"
            exit 1
      }
      ;;
"mh-letron-uat")
      echo "Your choice is mh-letron-UAT"
      PROJECT_ID=$PROJECT_LETRON_UAT
      check_or_create_configuration mh-letron-uat
      gcloud config set project $PROJECT_ID
      gcloud config configurations activate mh-letron-uat || {
            echo "Failed to activate configuration mh-letron-uat"
            exit 1
      }
      ;;
"mh-other-sportcms-bbg")
      echo "Your choice is mh-other-sportcms-bbg"
      PROJECT_ID=$PROJECT_BBG
      check_or_create_configuration mh-other-sportcms-bbg
      gcloud config set project $PROJECT_ID
      gcloud config configurations activate mh-other-sportcms-bbg || {
            echo "Failed to activate configuration mh-other-sportcms-bbg"
            exit 1
      }
      ;;
"other-sportcms-kq5L")
      echo "Your choice is anb1166"
      PROJECT_ID=$PROJECT_ANB1166 # 僅設置 PROJECT_ID
      check_or_create_configuration anb1166
      gcloud config set project $PROJECT_ID
      gcloud config configurations activate anb1166 || {
            echo "Failed to activate configuration anb1166"
            exit 1
      }
      ;;
"mh-aolong")
      echo "Your choice is mh-aolong"
      PROJECT_ID=$PROJECT_AOLONG
      ;;
"mh-vogue")
      echo "Your choice is mh-other-sportcms-vogue"
      PROJECT_ID=$PROJECT_VOGUE
      ;;
"sportscms-hb")
      echo "Your choice is sportscms-hb"
      PROJECT_ID=$PROJECT_SPORTSCMS_HB
      ;;
*)
      echo -e "$profiles_message"
      exit 1
      ;;
esac

# 切換配置後，顯式更新 PROJECT_ID 變數
PROJECT_ID=$(gcloud config get-value project)

# 然後在後續使用 PROJECT_ID 進行操作
echo "Current project ID: $PROJECT_ID"

# 檢查集群參數並動態設置配置名稱
if [ -n "$2" ] && [ -n "$3" ]; then
      CLUSTER_NAME=$2
      ZONE=$3

      # 檢查並創建集群配置
      check_or_create_configuration "$CLUSTER_NAME-$ZONE"
      echo "Activating configuration $CLUSTER_NAME-$ZONE and setting project to $PROJECT_ID"
      gcloud config configurations activate "$CLUSTER_NAME-$ZONE" || {
            echo "Failed to activate cluster configuration $CLUSTER_NAME-$ZONE"
            exit 1
      }
      gcloud config set project "$PROJECT_ID" || {
            echo "Failed to set project $PROJECT_ID"
            exit 1
      }

      # 切換到 Kubernetes 集群
      echo "Switching to Kubernetes cluster: $CLUSTER_NAME in zone: $ZONE"
      gcloud container clusters get-credentials "$CLUSTER_NAME" --zone "$ZONE" --project "$PROJECT_ID" || {
            echo "Failed to get credentials for cluster $CLUSTER_NAME"
            exit 1
      }
else
      echo "Please provide the cluster name and zone!"
      gcloud container clusters list --format="table(name, zone)" | tail -n +2

      echo -e "$profiles_message"
      exit 1
fi

# 顯示可用的 Kubernetes contexts
case ${4} in
"get-contexts")
      echo "kubectl config get-contexts"
      kubectl config get-contexts
      ;;
"list")
      echo "Your choice is instance list"
      gcloud compute instances list
      ;;
"ssh")
      echo "Your choice is ssh"
      zoneid=$(gcloud compute instances list --filter NAME=$2 | grep -v ZONE | awk -F " " '{print $2}')
      gcloud compute ssh $2 --zone $zoneid
      ;;
"status")
      echo "Your choice is get config list"
      gcloud config configurations list
      ;;
*)
      echo "No additional options selected."
      ;;
esac
