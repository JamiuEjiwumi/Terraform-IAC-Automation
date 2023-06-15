# Install nfs and erpnext RESOURCES
# resource "null_resource" "installCRDs" {
#   depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s]
# provisioner "local-exec" {
#   command = file("run.sh")
#   }
# }

# resource "null_resource" "apply_kubernetes_manifests" {
#   depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s]
#   provisioner "local-exec" {
#     command = "kubectl apply -f ${path.module}/kubernetes/keycloak/"
#   }
# }