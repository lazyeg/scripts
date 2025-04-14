#!/bin/bash

BACKUP_DIR="k8s-simple-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

RESOURCES=("ingress" "configmap" "secret" "deployment")  # 你可依需求加減
EXCLUDE_NAMESPACES=("kube-system" "kube-public" "kube-node-lease")

should_exclude() {
  local ns=$1
  for exclude in "${EXCLUDE_NAMESPACES[@]}"; do
    if [[ "$ns" == "$exclude" ]]; then
      return 0
    fi
  done
  return 1
}

for ns in $(kubectl get ns --no-headers -o custom-columns=":metadata.name"); do
  if should_exclude "$ns"; then
    echo "🚫 略過系統 namespace: $ns"
    continue
  fi

  mkdir -p "$BACKUP_DIR/$ns"
  for resource in "${RESOURCES[@]}"; do
    echo "🔄 備份 [$ns] $resource"
    kubectl get "$resource" -n "$ns" -o yaml \
      | yq 'del(.items[].status)' \
      > "$BACKUP_DIR/$ns/${resource}.yaml" 2>/dev/null
  done
done

echo "✅ 備份完成：$BACKUP_DIR"
echo "📦 備份所有 CRD（CustomResourceDefinition）..."
mkdir -p "$BACKUP_DIR/crds"
kubectl get crd -o yaml | yq 'del(.items[].status)' > "$BACKUP_DIR/crds/all-crds.yaml"

