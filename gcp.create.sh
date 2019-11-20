#!/bin/bash

echo "This gcloud create instance will print your selection !"
case ${1} in 


  "uat")
	echo "Your choice is uat env"
	gcloud config configurations activate default
	;;
  "dev")
	echo "Your choice is dev env"
	gcloud config configurations activate dev
	;;
  "dev-g")
	echo "Your choice is ubuntu 1804 for dev"
	gcloud beta compute --project=tonal-studio-176502 instances create a-devops-michael-demo-dev-1804-$2 --description=a-michael-demo-dev --zone=asia-east1-a --machine-type=g1-small --subnet=default --network-tier=PREMIUM  --metadata=startup-script=\#\!\ /bin/bash$'\n'apt-get\ update$'\n'apt-get\ install\ -y\ lrzsz$'\n'$'\n'EOF,ssh-keys=sysops:ssh-rsa\ AAAAB3NzaC1yc2EAAAADAQABAAABAQDB7/Pn0KoIqvnbwEJlG8aFufjO4F3ev4dRkHQy7p/FreqrsChTTGsJxZSpr8BIekTVcPmrhi4hYxCbxM47vHUEOAq9nr3RXccc95yVFX6iiiEgITfCgGWlpqRcCLttXbAQTQYGLQd8gikSoTkNeYHDxuLnecgYR9hCmABzyOJiDyaSkLVceNw9DD2SDh2th\+6WvMDi5ETY4rhsWALAhYLeKR4lUTzCvVumBSWwCp\+6EqRQJSkK7AOLS8hTJEcX69J0l/Rp8PIsLUXNHdC/u0MXIonynhwki0EP6V0hatnVe\+Ws7FLcO5G2HzWgdQDLjhtelp9iSktV9JqjkyfQk9dJ\ sysops@andy-uat-env  --maintenance-policy=MIGRATE --service-account=1079838449059-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=ubuntu-1804-bionic-v20191002 --image-project=ubuntu-os-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=a-michael-demo-dev-1804 --reservation-affinity=any
	;;
  "uat-g")
	echo "Your choice is ubuntu 1804 for uat"
	gcloud beta compute --project=uat-env-888888 instances create a-devops-michael-demo-uat-1804-$2 --description=a-michael-demo-uat --zone=asia-east1-a --machine-type=g1-small --subnet=default --network-tier=PREMIUM  --metadata=startup-script=\#\!\ /bin/bash$'\n'apt-get\ update$'\n'apt-get\ install\ -y\ lrzsz$'\n'$'\n'EOF,ssh-keys=sysops:ssh-rsa\ AAAAB3NzaC1yc2EAAAADAQABAAABAQDB7/Pn0KoIqvnbwEJlG8aFufjO4F3ev4dRkHQy7p/FreqrsChTTGsJxZSpr8BIekTVcPmrhi4hYxCbxM47vHUEOAq9nr3RXccc95yVFX6iiiEgITfCgGWlpqRcCLttXbAQTQYGLQd8gikSoTkNeYHDxuLnecgYR9hCmABzyOJiDyaSkLVceNw9DD2SDh2th\+6WvMDi5ETY4rhsWALAhYLeKR4lUTzCvVumBSWwCp\+6EqRQJSkK7AOLS8hTJEcX69J0l/Rp8PIsLUXNHdC/u0MXIonynhwki0EP6V0hatnVe\+Ws7FLcO5G2HzWgdQDLjhtelp9iSktV9JqjkyfQk9dJ\ sysops@andy-uat-env  --maintenance-policy=MIGRATE --service-account=731510304416-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=ubuntu-1804-bionic-v20191002 --image-project=ubuntu-os-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=a-michael-demo-uat-1804 --reservation-affinity=any
	;;
  "dev-g-16")
	echo "Your choice is ubuntu 1604 for dev "
	gcloud beta compute --project=tonal-studio-176502 instances create a-devops-michael-dev-1604-$2 --description=for-test --zone=asia-east1-a --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM  --metadata=startup-script=\#\!\ /bin/bash$'\n'apt-get\ update$'\n'apt-get\ install\ -y\ lrzsz$'\n'$'\n'EOF,ssh-keys=sysops:ssh-rsa\ AAAAB3NzaC1yc2EAAAADAQABAAABAQDB7/Pn0KoIqvnbwEJlG8aFufjO4F3ev4dRkHQy7p/FreqrsChTTGsJxZSpr8BIekTVcPmrhi4hYxCbxM47vHUEOAq9nr3RXccc95yVFX6iiiEgITfCgGWlpqRcCLttXbAQTQYGLQd8gikSoTkNeYHDxuLnecgYR9hCmABzyOJiDyaSkLVceNw9DD2SDh2th\+6WvMDi5ETY4rhsWALAhYLeKR4lUTzCvVumBSWwCp\+6EqRQJSkK7AOLS8hTJEcX69J0l/Rp8PIsLUXNHdC/u0MXIonynhwki0EP6V0hatnVe\+Ws7FLcO5G2HzWgdQDLjhtelp9iSktV9JqjkyfQk9dJ\ sysops@andy-uat-env  --maintenance-policy=MIGRATE --service-account=1079838449059-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --image=ubuntu-1604-xenial-v20191024 --image-project=ubuntu-os-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=a-michael-demo-dev-1604 --reservation-affinity=any
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
	echo "Usage ${0} { uat | dev | uat-g | dev-g | dev-g-16 | list | ssh | env-status }"
	;;
esac

