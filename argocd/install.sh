helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd -f values.yaml
kubectl apply -f ingress.yaml
sleep 30
ARGOCD_IP=$(kubectl get ingress argocd-server-ingress -n argocd --output jsonpath='{.spec.rules[0].host}')
echo "ArgoCD password :"
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo)
argocd login $ARGOCD_IP --username admin --password $ARGOCD_PASSWORD --insecure

argocd account update-password --current-password $ARGOCD_PASSWORD --new-password admin_password
argocd app create base --repo https://github.com/anthonydurot/devfest2021-kubernetes.git --revision main --path application/base --dest-server https://kubernetes.default.svc --dest-namespace base --sync-option CreateNamespace=true --sync-policy automatic
argocd app create cicd-injection --repo https://github.com/anthonydurot/devfest2021-kubernetes.git --revision main --path  application/injection-cicd --dest-server https://kubernetes.default.svc --dest-namespace injection-cicd --sync-option CreateNamespace=true --sync-policy automatic
argocd app create java-secret-manager --repo https://github.com/anthonydurot/devfest2021-kubernetes.git --revision main --path  application/java-secret-manager --dest-server https://kubernetes.default.svc --dest-namespace java-secret-manager --sync-option CreateNamespace=true --sync-policy automatic
argocd app create java-vault --repo https://github.com/anthonydurot/devfest2021-kubernetes.git --revision main --path  application/java-vault --dest-server https://kubernetes.default.svc --dest-namespace java-vault --sync-option CreateNamespace=true --sync-policy automatic
argocd app create iam-db-authentification --repo https://github.com/anthonydurot/devfest2021-kubernetes.git --revision main --path  application/iam-db-authentification --dest-server https://kubernetes.default.svc --dest-namespace iam-db-authentification --sync-option CreateNamespace=true --sync-policy automatic
argocd app create sealed-secrets --repo https://github.com/anthonydurot/devfest2021-kubernetes.git --revision main --path  application/sealed-secrets --dest-server https://kubernetes.default.svc --dest-namespace demo-sealed-secrets --sync-option CreateNamespace=true --sync-policy automatic