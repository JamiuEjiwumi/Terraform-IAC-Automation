resource "kubernetes_persistent_volume_claim" "data" {
    depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "data"
  }
  
  spec {
    access_modes = ["ReadWriteOnce"]
    
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

resource "kubernetes_secret" "keycloak_postgres_credentials" {
     depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "keycloak-postgres-credentials"
  }

  type = "Opaque"

  data = {
    POSTGRES_USER     = "a2V5Y2xvYWs="
    POSTGRES_PASSWORD = "a2V5Y2xvYWs="
  }
}

# resource "kubernetes_deployment" "keycloak_postgres" {
#      depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s
#   ]
#   metadata {
#     name = "keycloak-postgres"
#   }

#   spec {
#     selector {
#       match_labels = {
#         app = "keycloak-postgres"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "keycloak-postgres"
#         }
#       }

#       spec {
#         service_account_name = "postgres-service-account"

#         security_context {
#           run_as_user = 999
#           fs_group    = 999
#         }

#         container {
#           name  = "postgres"
#           image = "postgres:13-alpine"

#           env {
#             name = "POSTGRES_USER"
#             value_from {
#               secret_key_ref {
#                 name = kubernetes_secret.keycloak_postgres_credentials.metadata[0].name
#                 key  = "POSTGRES_USER"
#               }
#             }
#           }

#           env {
#             name = "POSTGRES_PASSWORD"
#             value_from {
#               secret_key_ref {
#                 name = kubernetes_secret.keycloak_postgres_credentials.metadata[0].name
#                 key  = "POSTGRES_PASSWORD"
#               }
#             }
#           }

#           env {
#             name  = "POSTGRES_DB"
#             value = "keycloak"
#           }

#           port {
#             container_port = 5432
#             name           = "postgres"
#           }

#           volume_mount {
#             name       = "keycloak-postgres-storage"
#             mount_path = "/var/lib/postgresql/data"
#           }
#         }

#         volume {
#           name = "keycloak-postgres-storage"

#           persistent_volume_claim {
#             claim_name = kubernetes_persistent_volume_claim.data.metadata[0].name
#           }
#         }
#       }
#     }
#   }
# }

data "kubernetes_persistent_volume_claim" "data" {
     depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "data"
  }
}
  
data "kubernetes_secret" "keycloak_postgres_credentials" {
     depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "keycloak-postgres-credentials"
  }
}

resource "kubernetes_service" "keycloak_postgres" {
     depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "keycloak-postgres"
  }

  spec {
    selector = {
      app = "keycloak-postgres"
    }

    port {
      name       = "postgres"
      port       = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_deployment" "keycloak" {
     depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "keycloak"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "keycloak"
      }
    }

    template {
      metadata {
        labels = {
          app = "keycloak"
        }
      }

      spec {
        container {
          name  = "keycloak"
          image = "quay.io/keycloak/keycloak:21.0.2"
          args  = ["start-dev"]

          env {
            name  = "DB_VENDOR"
            value = "POSTGRES"
          }

          env {
            name  = "DB_ADDR"
            value = "keycloak-postgres"
          }

          env {
            name  = "DB_PORT"
            value = "5432"
          }

          env {
            name  = "DB_DATABASE"
            value = "keycloak"
          }

          env {
            name = "DB_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.keycloak_postgres_credentials.metadata[0].name
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.keycloak_postgres_credentials.metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }

          env {
            name  = "KEYCLOAK_ADMIN"
            value = "parallelscore"
          }

          env {
            name  = "KEYCLOAK_ADMIN_PASSWORD"
            value = "Key@#admin78!/"
          }

          env {
            name  = "KC_HTTP_ENABLED"
            value = "true"
          }

          env {
            name  = "KEYCLOAK_HTTP_PORT"
            value = "8080"
          }

          env {
            name  = "KEYCLOAK_HTTPS_PORT"
            value = "8443"
          }

          env {
            name  = "KEYCLOAK_FRONTEND_URL"
            value = "https://keycloak.cloakio.dev"
          }

          env {
            name  = "KC_PROXY"
            value = "passthrough"
          }

          port {
            name          = "http"
            container_port = 8080
          }

          port {
            name          = "https"
            container_port = 8443
          }

          readiness_probe {
            http_get {
              path = "/realms/master"
              port = 8080
            }
            initial_delay_seconds = 60
            period_seconds        = 1
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "keycloak" {
     depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "keycloak"
  }

  spec {
    selector = {
      app = "keycloak"
    }

    port {
      name       = "https"
      port       = 80
      target_port = 8080
    }
  }
}

# data "kubernetes_secret" "keycloak_postgres_credentials" {
#      depends_on = [
#     digitalocean_kubernetes_cluster.lafia-k8s
#   ]
#   metadata {
#     name = "keycloak-postgres-credentials"
#   }
# }

