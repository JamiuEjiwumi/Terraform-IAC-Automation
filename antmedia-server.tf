resource "kubernetes_deployment" "media" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging
  ]

  metadata {
    name = "ant-media"
    labels = {
      App = "ant-media"
    }
    namespace = "staging"
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "ant-media"
      }
    }
    template {
      metadata {
        labels = {
          App = "ant-media"
        }
      }
      spec {
        container {
          image = "antmedia/enterprise:latest"
          name  = "ant-media"

          image_pull_policy = "Always"

          port {
            container_port = 5080
          }

          resources {
            limits = {
              cpu    = "250"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "500Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "media_service" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_namespace.staging, kubernetes_deployment.media
  ]

  metadata {
    name      = "ant-media"
    namespace = "staging"
  }
  spec {
    
    selector = {
      App = kubernetes_deployment.media.spec.0.template.0.metadata[0].labels.App #kubernetes_deployment.videomerger.spec.0.template.0.metadata[0].labels.app
    }
    port {
      # protocol= "TCP"
      port        = 80
      target_port = 5080
      # node_port = 30012
    }
     type = "ClusterIP" #"ClusterIP" #type = "LoadBalancer"
  }
}
