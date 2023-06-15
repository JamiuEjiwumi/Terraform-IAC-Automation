resource "kubernetes_deployment" "suresalama-cms" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging
  ]

  metadata {
    name = "suresalama-cms"
    labels = {
      App = "suresalama-cms"
    }
    namespace = "staging"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "suresalama-cms"
      }
    }
    template {
      metadata {
        labels = {
          App = "suresalama-cms"
        }
      }
      spec {
        container {
          image = "parallelscore/suresalama-cms:latest"
          name  = "suresalama-cms"

          image_pull_policy = "Always"

          port {
            container_port = 1337
          }

          resources {
            limits = {
              cpu    = "250"
              memory = "1500Mi"
            }
            requests = {
              cpu    = "150m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "suresalama-cms" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging, kubernetes_deployment.fhir
  ]

  metadata {
    name      = "suresalama-cms"
    namespace = "staging"
  }
  # timeouts {
  #   create = "50s" # for testing errors
  # }
  spec {
    
    selector = {
      App = kubernetes_deployment.suresalama-cms.spec.0.template.0.metadata[0].labels.App #kubernetes_deployment.videomerger.spec.0.template.0.metadata[0].labels.app
    }
    port {
      # protocol= "TCP"
      port        = 80
      target_port = 1337
      # node_port = 30012
    }
     type = "ClusterIP" #"ClusterIP" #type = "LoadBalancer"
  }
}