# resource "kubernetes_deployment" "account" {
#   depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging
#   ]

#   metadata {
#     name = "account-service"
#     labels = {
#       App = "account-service"
#     }
#     namespace = "staging"
#   } 

#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         App = "account-service"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           App = "account-service"
#         }
#       }
#       spec {
#         # image_pull_secrets {
#         #     name =  kubernetes_secret.example.metadata.0.name
#         # }
#         container {
#           image = "registry.digitalocean.com/lafia-dcr/account-service:c1a6aa3"
#           name  = "account-service"

#           image_pull_policy = "Always"

#           port {
#             container_port = 7000
#           }

#           resources {
#             limits = {
#               cpu    = "250"
#               memory = "512Mi"
#             }
#             requests = {
#               cpu    = "250m"
#               memory = "500Mi"
#             }
#           }
#         }
#       }
#     }
#   }
# }


# resource "kubernetes_service" "account_service" {
#   depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging, kubernetes_deployment.account
#   ]

#   metadata {
#     name      = "account-service"
#     namespace = "staging"
#   }
#   # timeouts {
#   #   create = "50s" # for testing errors
#   # }
#   spec {
    
#     selector = {
#       App = kubernetes_deployment.account.spec.0.template.0.metadata[0].labels.App
#     }
#     port {
#       # protocol= "TCP"
#       port        = 7000
#       target_port = 7000
#       # node_port = 30012
#     }
#      type = "ClusterIP" #"ClusterIP" #type = "LoadBalancer"
#   }
# }