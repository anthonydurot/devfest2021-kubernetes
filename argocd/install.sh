helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd -f values.yaml
kubectl apply -f ingress.yaml
sleep 30
ARGOCD_IP=$(kubectl get ingress argocd-server-ingress -n argocd --output jsonpath='{.spec.rules[0].host}')
echo "ArgoCD password :"
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo)
argocd login $ARGOCD_IP --username admin --password $ARGOCD_PASSWORD --insecure
argocd app create devfest --repo https://github.com/anthonydurot/devfest-2021.git --revision main --path kubernetes/application --dest-server https://kubernetes.default.svc --dest-namespace devfest --sync-option CreateNamespace=true --sync-policy automatic
argocd app create devfest-cicd-injection --repo https://github.com/anthonydurot/devfest-2021.git --revision injection-secret-cicd --path kubernetes/application --dest-server https://kubernetes.default.svc --dest-namespace devfest-cicd-injection --sync-option CreateNamespace=true --sync-policy automatic
argocd app create devfest-secret-manager --repo https://github.com/anthonydurot/devfest-2021.git --revision recuperation-java-secrets-manager --path kubernetes/application --dest-server https://kubernetes.default.svc --dest-namespace devfest-secret-manager --sync-option CreateNamespace=true --sync-policy automatic
argocd app create devfest-vault --repo https://github.com/anthonydurot/devfest-2021.git --revision recuperation-vault --path kubernetes/application --dest-server https://kubernetes.default.svc --dest-namespace devfest-vault --sync-option CreateNamespace=true --sync-policy automatic
