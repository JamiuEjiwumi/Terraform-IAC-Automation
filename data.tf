data "kubernetes_service" "ingress" {

  depends_on = [helm_release.ingress-nginx]

  metadata {
    name      = "ingress-nginx-controller"
    namespace = var.ingress-namespace
  }
}


# data "kubernetes_service" "postgres" {

#   depends_on = [helm_release.postgres]

#   metadata {
#     name      = var.postgres-service-name
#     namespace = var.postgres-namespace
#   }
# }

# data "kubernetes_service" "openhim_core" {
#   depends_on = [kubernetes_service.openhim_core]
#   metadata {
#     name = "openhim-core"
#   }
# }
