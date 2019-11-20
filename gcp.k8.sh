#!/bin/bash
# Program:
#	This script only accepts the flowing parameter: one, two or three.
# History:
# 2015/07/17	VBird	First release
#PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
#export PATH

echo "This k8s both uat and prod program will print your selection !"
# read -p "Input your choice: " choice   # 暫時取消，可以替換！
# case ${choice} in                      # 暫時取消，可以替換！
case ${1} in                             # 現在使用，可以用上面兩行替換！

  "uat-env")
	echo "Your choice is uat and uat-k8s"
	gcloud config configurations activate default
	gcloud container clusters get-credentials mlytics-uat-fcdn
	;;
  "prod-env")
	echo "Your choice is prod and prod-k8s"
	gcloud config configurations activate  prod
	gcloud container clusters get-credentials --zone asia-east1-a mlytics-prod-fcdn
	;;
  "pod")
	echo "Your choice is get pod"
	kubectl get pod
	;;
  "list")
	echo "Your choice is instance list "
        gcloud compute instances list
	;;
  "ssh")
	echo "Your choice is ssh"
        gcloud compute ssh $2 --zone $3
	;;
  "env-status")
	echo "Your choice is get config list"
	gcloud config configurations list
	;;
  *)
	echo "Usage ${0} { uat-env | prod-env | pod | list | ssh | env-status }"
	;;
esac

