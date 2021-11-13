helm repo add hashicorp https://helm.releases.hashicorp.com
helm install vault hashicorp/vault --namespace vault -f values.yaml --create-namespace
kubectl apply -f ingress.yaml