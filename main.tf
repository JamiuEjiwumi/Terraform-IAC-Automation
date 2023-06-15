terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      #version = "~> 2.0"
    }

    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = ">= 2.4"
    # }

    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }

    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.18.0"
    }
  }
}

# Configure the DigitalOcean Provider 
provider "digitalocean" {
  token = var.DIGITALOCEAN_TOKEN
}

#CREATE CLUSTER
resource "digitalocean_kubernetes_cluster" "lafia-k8s" {
  name   = var.cluster-name
  region = var.region
  version = "1.26.3-do.0"
 

  node_pool {
    name       = "${var.cluster-name}-worker-pool"
    size       = "m-2vcpu-16gb"
    node_count = var.node_count
    auto_scale = true
    min_nodes  = 2
    max_nodes  = 5
  }

  provisioner "local-exec" {
    command = "doctl kubernetes cluster kubeconfig save ${digitalocean_kubernetes_cluster.lafia-k8s.id}"

  }
}

# CONNECT TO CLUSTER
provider "kubernetes" {
  host             = digitalocean_kubernetes_cluster.lafia-k8s.endpoint
  token            = digitalocean_kubernetes_cluster.lafia-k8s.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.lafia-k8s.kube_config[0].cluster_ca_certificate
  )
}

provider "helm" {
  kubernetes {
    host                   = digitalocean_kubernetes_cluster.lafia-k8s.endpoint
    token                  = digitalocean_kubernetes_cluster.lafia-k8s.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.lafia-k8s.kube_config[0].cluster_ca_certificate)
    }
  experiments {
    manifest = "true"
  }
}

# CREATE NAMESPACE
resource "kubernetes_namespace" "staging" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "staging"
  }
}

resource "kubernetes_namespace" "production" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "production"
  }
}

resource "kubernetes_namespace" "keda" {
  depends_on = [
    digitalocean_kubernetes_cluster.lafia-k8s
  ]
  metadata {
    name = "keda"
  }
}

# Add an A record to the domain for www.example.com.
resource "digitalocean_record" "lafia-backend" {
  domain = var.dns-name
  type   = "A"
  name   = "lafia-backend"
  value  = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}



resource "digitalocean_record" "suresalama-backend" {
  domain = var.dns-name
  type   = "A"
  name   = "suresalama-backend"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}



resource "digitalocean_record" "fhir-server" {
  domain = var.dns-name
  type   = "A"
  name   = "fhir-server"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}



resource "digitalocean_record" "suresalama-cms" {
  domain = var.dns-name
  type   = "A"
  name   = "suresalama-cms"
  value  = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}



resource "digitalocean_record" "ant-media" {
  domain = var.dns-name
  type   = "A"
  name   = "ant-media"
  value  = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}



resource "digitalocean_record" "lafia-cms" {
  domain = var.dns-name
  type   = "A"
  name   = "lafia-cms"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}



resource "digitalocean_record" "lafia-dhis2" {
  domain = var.dns-name
  type   = "A"
  name   = "lafia-dhis2"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "openhim-console" {
  domain = var.dns-name
  type   = "A"
  name   = "openhim-console"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "keycloak" {
  domain = var.dns-name
  type   = "A"
  name   = "keycloak"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "redis" {
  domain = var.dns-name
  type   = "A"
  name   = "lafia.redis"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "apisix-dashboard" {
  domain = var.dns-name
  type   = "A"
  name   = "apisix-dashboard"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}

resource "digitalocean_record" "apisix" {
  domain = var.dns-name
  type   = "A"
  name   = "apisix"
  value = data.kubernetes_service.ingress.status.0.load_balancer.0.ingress.0.ip
}