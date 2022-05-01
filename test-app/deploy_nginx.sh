#!/bin/bash

## First cluster ##
export clustername="primary"
export region=$(gcloud container clusters list | grep $clustername | awk '{print $2}')
gcloud container clusters get-credentials $clustername --region $region

# Should show nodes from the first cluster
kubectl get nodes

# Create namespace for nginx
kubectl create namespace nginx

# Change namespace
kubectl config set-context --current --namespace=nginx

# Deploy Nginx
kubectl apply -f nginx.yaml

# Wait until Nginx is ready
kubectl wait pods -l app=nginx --for condition=Ready --timeout=60s
sleep 3
kubectl get pods

## Secondary cluster ##
export clustername="secondary"
export region=$(gcloud container clusters list | grep $clustername | awk '{print $2}')
gcloud container clusters get-credentials $clustername --region $region

# Should show nodes from the first cluster
kubectl get nodes

# Create namespace for nginx
kubectl create namespace nginx

# Change namespace
kubectl config set-context --current --namespace=nginx

# Deploy Nginx
kubectl apply -f nginx.yaml

# Wait until Nginx is ready
kubectl wait pods -l app=nginx --for condition=Ready --timeout=60s
sleep 3
kubectl get pods

## Multi-cluster service
export clustername="primary"
export region=$(gcloud container clusters list | grep $clustername | awk '{print $2}')
gcloud container clusters get-credentials $clustername --region $region

kubectl config set-context --current --namespace=nginx

kubectl apply -f mcs.yaml
echo "Sleeping for 30 seconds"
sleep 30
kubectl get mcs
kubectl describe mcs nginx-mcs

## Multi-cluster ingress
kubectl apply -f mci.yaml
echo "Sleeping for 30 seconds"
sleep 30
kubectl get mci
kubectl describe nginx-mci

# Showing VIP address
kubectl describe mci nginx-mci -n nginx | grep VIP | tail -1
