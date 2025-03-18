<!--
 * @Author: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @Date: 2025-03-18 11:38:28
 * @LastEditors: error: error: git config user.name & please set dead value or install git && error: git config user.email & please set dead value or install git & please set dead value or install git
 * @LastEditTime: 2025-03-18 11:59:01
 * @FilePath: /gcp/README.md
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
-->
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

