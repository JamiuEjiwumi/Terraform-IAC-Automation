#!/bin/bash

# INSTALL nfs 
# kubectl create namespace nfs
# helm repo add nfs-ganesha-server-and-external-provisioner https://kubernetes-sigs.github.io/nfs-ganesha-server-and-external-provisioner/
# helm repo update
# helm upgrade --install -n nfs in-cluster nfs-ganesha-server-and-external-provisioner/nfs-server-provisioner --set=image.tag=v3.0.0, --set 'storageClass.mountOptions={vers=4.1}' --set persistence.enabled=true --set persistence.size=9Gi

# # INSTALL erpnext
# kubectl create namespace erpnext
# helm repo add frappe https://helm.erpnext.com
# helm repo update
# helm upgrade --install frappe-bench --namespace erpnext frappe/erpnext --set persistence.worker.storageClass=nfs

# Clone the Helm chart for ERPNext
# git clone git@github.com:frappe/helm.git

#  

# # Set the working directory to the ERPNext Helm chart
# cd helm/erpnext

#  

# # Create a custom-values.yaml file with site configuration
# cat <<EOF > custom-values.yaml
# jobs:
#   createSite:
#     enabled: true
#     siteName: "devapp.lafia.io"
#     adminPassword: "secret"
# EOF

# # Create a job to create a new site using the custom values
# helm template frappe-bench -n erpnext frappe/erpnext -f custom-values.yaml -s templates/job-create-site.yaml > create-new-site-job.yaml
# kubectl apply -f create-new-site-job.yaml -n erpnext

# # Create an ingress to route traffic from the internet to the ERPNext service
# cat <<EOF > ingress.yaml
# apiVersion: networking.k8s.io/v1
# kind: Ingress
# metadata:
#   name: erp-resource
#   annotations:
#     kubernetes.io/ingress.class: "nginx"
#     nginx.ingress.kubernetes.io/ssl-redirect: "false"
# spec:
#   rules:
#     - host: "devapp.lafia.io"
#       http:
#         paths:
#           - path: "/"
#             pathType: Prefix
#             backend:
#               service:
#                 name: frappe-bench-erpnext
#                 port:
#                   name: http
# EOF



# kubectl apply -f ingress.yaml -n erpnext

# INSTALL nginx
# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm repo update
# helm install nginx-ingress ingress-nginx/ingress-nginx --set controller.publishService.enabled=true

# git clone git@github.com:frappe/helm.git && cd "$(basename "$_" /helm/erpnext)"
# touch custom-value.yaml
# ls

# file_location=/helm/erpnext/$1.yaml
# if [ -e $policy ]; then
#   echo "File $1.yaml already exists!"
# else
#   cat > $file_location <<EOF
# {
#       jobs:
#         createSite:
#             enabled: true
#             siteName: "devapp.lafia.io "
#             adminPassword: "secret"
#       }
#     }
# EOF
# fi


# cd /helm/erpnext
# helm template frappe-bench -n erpnext frappe/erpnext -f custom-values.yaml -s templates/job-create-site.yaml > create-new-site-job.yaml
# kubectl apply -f create-new-site-job.yaml -n erpnext

# helm install nginx-ingress ingress-nginx/ingress-nginx


# Clone the autoscaler repository
git clone https://github.com/kubernetes/autoscaler.git

cd autoscaler/vertical-pod-autoscaler/

./hack/vpa-up.sh

cd ../../

rm -rf autoscaler/