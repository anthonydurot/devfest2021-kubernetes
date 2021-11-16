printf "### Récupération d'un secret non chiffré ###\n\n\n"
sleep 1
printf "kubectl get secret my-secret -o yaml \n\n\n"
sleep 1
kubectl get secret my-secret -o yaml
sleep 1
printf "\n\n\n### Utilisation du secret non chiffré en entrée de kubeseal ###\n\n\n"
sleep 1
printf "kubectl get secret my-secret -o yaml |  kubeseal --controller-name=my-sealed-secrets --controller-namespace=sealed-secrets --format yaml > mon_secret_chiffré.yaml\n\n\n"
sleep 1
kubectl get secret my-secret -o yaml |  kubeseal --controller-name=my-sealed-secrets --controller-namespace=sealed-secrets --format yaml > mon_secret_chiffré.yaml
sleep 1
printf "cat mon_secret_chiffré.yaml\n\n\n"
sleep 1
cat mon_secret_chiffré.yaml
sleep 1
printf "\n\n\n###Application du secret chiffré sur le cluster Kubernetes###\n\n\n"
sleep 1
printf "kubectl apply -f mon_secret_chiffré.yaml\n\n\n"
sleep 1
kubectl apply -f mon_secret_chiffré.yaml

