resource "kubernetes_ingress_v1" "lafia-backend" {
  wait_for_load_balancer = true
  # depends_on = [helm_release.airflow]
  metadata {
    name      = "lafia-backend"
    namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["lafia-backend.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.lafia-backend.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "lafia-backend" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "9500" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_ingress_v1" "suresalama-backend" {
  wait_for_load_balancer = true
  # depends_on = [helm_release.airflow]
  metadata {
    name      = "suresalama-backend"
    namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["suresalama-backend.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.suresalama-backend.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "suresalama-backend" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "9500" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}



resource "kubernetes_ingress_v1" "suresalama-cms" {
  wait_for_load_balancer = true
  # depends_on = [helm_release.airflow]
  metadata {
    name      = "suresalama-cms"
    namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["suresalama-cms.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.suresalama-cms.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "suresalama-cms" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "1337" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}


# resource "kubernetes_ingress_v1" "suresalama-frontend" {
#   wait_for_load_balancer = true
#   # depends_on = [helm_release.airflow]
#   metadata {
#     name      = "suresalama-frontend"
#     namespace = "staging"
#   }
#   spec {
#     ingress_class_name = "nginx"
#     tls {
#       hosts = ["suresalama-frontend.${var.dns-name}"]
#       secret_name = "suresalama-frontend-secret"
#     }
#     rule {
#       host = "suresalama-frontend.${var.dns-name}"
#       http {
#         path {
#           path = "/"
#           backend {
#             service {
#               name = "suresalama-frontend" # data.kubernetes_service.airflow.metadata.0.name
#               port {
#                 number = "9500" # data.kubernetes_service.airflow.spec.0.port.0.port
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }


resource "kubernetes_ingress_v1" "lafia-cms" {
  wait_for_load_balancer = true
  # depends_on = [helm_release.airflow]
  metadata {
    name      = "lafia-cms"
    namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["lafia-cms.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.lafia-cms.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "lafia-cms" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "1337" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "fhir-server" {
  wait_for_load_balancer = true
  # depends_on = [helm_release.airflow]
  metadata {
    name      = "fhir-server"
    namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["fhir-server.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.fhir-server.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "fhir-server" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "8080" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "ant-media" {
  wait_for_load_balancer = true
  # depends_on = [helm_release.airflow]
  metadata {
    name      = "ant-media"
    namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["ant-media.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.ant-media.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "ant-media" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "5080" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "lafia-dhis2" {
  wait_for_load_balancer = true
  metadata {
    name      = "lafia-dhis2"
    namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["lafia-dhis2.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.lafia-dhis2.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "lafia-dhis2" # data.kubernetes_service.lafia.metadata.0.name
              port {
                number = "8080" # data.kubernetes_service.lafia.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "openhim-console" {
  wait_for_load_balancer = true
  metadata {
    name      = "openhim-console"
    # namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["lafia-openhim.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.openhim-console.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "openhim-console" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "80" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_ingress_v1" "keycloak" {
  wait_for_load_balancer = true
  metadata {
    name      = "keycloak"
    # namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["keycloak.${var.dns-name}"]
      secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.keycloak.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "keycloak" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "8080" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "apisix-dashboard" {
  wait_for_load_balancer = true
  metadata {
    name      = "apisix-dashboard"
    # namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["apisix-dashboard.${var.dns-name}"]
      secret_name = "apisix-dashboard-cert-secret"
    }
    rule {
      host = digitalocean_record.apisix-dashboard.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "apisix-dashboard" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "80" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "apisix" {
  wait_for_load_balancer = true
  metadata {
    name      = "apisix"
    # namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["apisix.${var.dns-name}"]
      secret_name = "apisix-cert-secret"
    }
    rule {
      host = digitalocean_record.apisix.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "apisix" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "9180" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress_v1" "my-release-redis-master" {
  wait_for_load_balancer = true
  metadata {
    name      = "my-release-redis-master"
    # namespace = "staging"
    
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      hosts = ["my-release-redis-master.${var.dns-name}"]
      # secret_name = "lafia-cert-secret"
    }
    rule {
      host = digitalocean_record.redis.fqdn
      http {
        path {
          path = "/"
          backend {
            service {
              name = "my-release-redis-master" # data.kubernetes_service.airflow.metadata.0.name
              port {
                number = "6379" # data.kubernetes_service.airflow.spec.0.port.0.port
              }
            }
          }
        }
      }
    }
  }
}