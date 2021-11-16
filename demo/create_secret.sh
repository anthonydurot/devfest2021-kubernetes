#!/bin/bash
printf "###Création du secret###\n\n\n"
printf "kubectl create secret generic my-secret --from-literal=username=anthony --from-literal=password=monsupermotdepasse\n\n\n"
kubectl create secret generic my-secret --from-literal=username=anthony --from-literal=password="monsupermotdepasse"
sleep 2
printf "\n\n\n###Récupération du secret###\n\n\n"
printf "kubectl get secret my-secret -o yaml\n\n\n"
kubectl get secret my-secret -o yaml
sleep 5
printf "\n\n\nkubectl get secret my-secret --template={{.data.username}} | base64 -d\n\n\n"
kubectl get secret my-secret --template={{.data.username}} | base64 -d
sleep 2
printf "\n\n\nkubectl get secret my-secret --template={{.data.password}} | base64 -d\n\n\n"
kubectl get secret my-secret --template={{.data.password}} | base64 -d
printf "\n\n\n"
sleep 2
kubectl delete secret my-secret