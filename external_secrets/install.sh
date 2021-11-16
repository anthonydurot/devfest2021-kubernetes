helm repo add external-secrets https://external-secrets.github.io/kubernetes-external-secrets/
helm install external-secrets external-secrets/kubernetes-external-secrets --namespace external-secrets --create-namespace -f values.yaml
