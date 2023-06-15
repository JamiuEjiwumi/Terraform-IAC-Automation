# resource "kubernetes_deployment" "pd" {
#   depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging
#   ]

#   metadata {
#     name = "provider-dir"
#     labels = {
#       App = "provider-dir"
#     }
#     namespace = "staging"
#   }

#   spec {
#     replicas = 1
#     selector {
#       match_labels = {
#         App = "provider-dir"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           App = "provider-dir"
#         }
#       }
#       spec {
#         # image_pull_secrets {
#         #     name =  kubernetes_secret.example.metadata.0.name
#         # }
#         container {
#           image = "registry.digitalocean.com/lafia-dcr/provider-directory:9538c96"
#           name  = "provider-dir"

#           image_pull_policy = "Always"

#           port {
#             container_port = 9500
#           }

#           resources {
#             limits = {
#               cpu    = "50"
#               memory = "52Mi"
#             }
#             requests = {
#               cpu    = "50m"
#               memory = "50Mi"
#             }
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "pd_service" {
#   depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging, kubernetes_deployment.pd
#   ]

#   metadata {
#     name      = "provider-dir"
#     namespace = "staging"
#   }
#   # timeouts {
#   #   create = "50s" # for testing errors
#   # }
#   spec {
    
#     selector = {
#       App = kubernetes_deployment.pd.spec.0.template.0.metadata[0].labels.App #kubernetes_deployment.videomerger.spec.0.template.0.metadata[0].labels.app
#     }
#     port {
#       # protocol= "TCP"
#       port        = 9500
#       # target_port = 9500
#       # node_port = 30012
#     }
#      type = "ClusterIP" #"ClusterIP" #type = "LoadBalancer"
#   }
# }