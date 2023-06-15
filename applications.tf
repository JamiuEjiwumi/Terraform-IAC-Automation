resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.4.2"
  namespace        = var.ingress-namespace
  create_namespace = true
  wait             = true
  timeout          = 500
  depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s]
  values           = ["${file("./charts/ingress/ingress.yaml")}"]
}



resource "helm_release" "postgres" {
  name             = "postgres"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "postgresql"
  version          = "12.1.14"
  namespace        = var.postgres-namespace
  create_namespace = true
  wait             = true
  depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s]
  timeout          = 50
  values           = ["${file("./charts/postgres/postgres.yaml")}"]

  set_sensitive {
    name  = "global.postgresql.auth.postgresPassword"
    value = var.POSTGRES_ADMIN_PASSWORD
  }

  set {
    name  = "global.postgresql.auth.username"
    value = var.lafia-admin
  }

  set_sensitive {
    name  = "global.postgresql.auth.password"
    value = var.LAFIA_ADMIN_PASSWORD
  }
}

# resource "postgresql_database" "lafia" {
#   name       = "lafia-backenddb"
#   depends_on = [helm_release.postgres]
# }

# resource "postgresql_database" "suresalama" {
#   name       = "suresalama-backenddb"
#   depends_on = [helm_release.postgres]
# }

resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.11.0"
  namespace        = var.cert-manager-namespace
  create_namespace = true
  wait             = true
  timeout          = 500
  depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s]
  values           = ["${file("./charts/cert-manager/cert-manager.yaml")}"]

  set {
    name  = "installCRDs"
    value = true
  }
}

# resource "helm_release" "lafia_dhis2" {
#   chart      = "opensrp/dhis2"
#   name       = "lafia-dhis2"
#   # repository = "https://helm.smartregister.org"
#   namespace  = "staging"
#   values     = [file("./charts/dhis2/values.yaml")]
#   depends_on = [helm_release.vpa]
# }

resource "helm_release" "rabbitmq" {
  name             = "rabbitmq"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "rabbitmq"
  version          = "11.15.2"
  namespace        = var.rabbitmq-namespace
  create_namespace = true
  wait             = true
  timeout          = 500
  depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s]
  values           = ["${file("./charts/rabbitmq/rabbitmq.yaml")}"]

  set {
    name = "auth.username"
    value = var.lafia-admin
  }

  set_sensitive {
    name = "auth.password"
    value = var.LAFIA_ADMIN_PASSWORD
  }

  set {
    name  = "auth.erlangCookie"
    value = var.rabbitmq_erlang_cookie
  }
}

# resource "helm_release" "apisix" {
#   name             = "apisix"
#   repository       = "https://charts.apiseven.com"
#   chart            = "apisix"
#   version          = "1.4.0"
#   # namespace       = var.apisix_namespace
#   timeout          = 300
#   depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s]
#   values           = ["${file("./charts/apisix/apisix.yaml")}"]
# }

# resource "helm_release" "opensrp-web" {
#   name       = "opensrp-web"
#   chart      = "opensrp/opensrp-web"
#   # repository = "https://helm.smartregister.org"
#   namespace  = "staging"
#   values     = [file("./charts/opensrp-web/values.yaml")]
#   depends_on = [helm_release.vpa]
# }

resource "helm_release" "redis" {
  name             = "my-release"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "redis"
  version          = "17.10.3"
  namespace        = var.redis_namespace
  create_namespace = true
  wait             = true
  timeout          = 500
  depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s]
  values           = ["${file("./charts/redis/redis.yaml")}"]

  set {
    name  = "host"
    value = var.redis_host
  }

  set {
    name  = "port"
    value = var.redis_port
  }

  set_sensitive {
    name  = "username"
    value = var.redis_username
  }

  set_sensitive {
    name  = "password"
    value = var.redis_password
  }
}


# resource "helm_release" "nfs_server" {
#   name       = "nfs-ganesha-server-and-external-provisioner"
#   repository = "https://kubernetes-charts.storage.googleapis.com/"
#   chart      = "nfs-ganesha-server-and-external-provisioner/nfs-server-provisioner"
#   namespace  = "nfs"

#   set {
#     name  = "image.tag"
#     value = "v3.0.0"
#   }

#   set {
#     name  = "storageClass.mountOptions"
#     value = "{vers=4.1}"
#   }

#   set {
#     name  = "persistence.enabled"
#     value = "true"
#   }

#   set {
#     name  = "persistence.size"
#     value = "9Gi"
#   }
# }

# resource "helm_release" "frappe_bench" {
#   name       = "frappe-bench"
#   chart      = "frappe/erpnext"
#   namespace  = "erpnext"
#   wait       = true
#   timeout    = 600

#   set {
#     name  = "persistence.worker.storageClass"
#     value = "nfs"
#   }

#   depends_on = [digitalocean_kubernetes_cluster.lafia-k8s, helm_release.nfs_server]
# }

# resource "helm_release" "keycloak" {
#   name             = "keycloak"
#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "keycloak"
#   version          = "14.2.0"
#   namespace        = var.keycloak-namespace
#   create_namespace = true
#   wait             = true
#   timeout          = 500
#   depends_on       = [helm_release.neo4j]
#   values           = ["${file("./charts/keycloak/keycloak.yaml")}"]

#   set {
#     name = "auth.adminUser"
#     value = var.amplify-lafia-admin
#   }

#   set_sensitive {
#     name = "auth.adminPassword"
#     value = var.AMPLIFY_LAFIA_ADMIN_PASSWORD
#   }

#   set_sensitive {
#     name = "postgresql.auth.postgresPassword"
#     value = var.POSTGRES_ADMIN_PASSWORD
#   }

#   set_sensitive {
#     name = "postgresql.auth.username"
#     value = var.amplify-lafia-admin
#   }

#   set_sensitive {
#     name = "postgresql.auth.password"
#     value = var.AMPLIFY_LAFIA_ADMIN_PASSWORD
#   }

#   # set {
#   #   name = "externalDatabase.host"
#   #   value = "yb-tservers.database.svc.cluster.local"
#   # }

#   # set {
#   #   name = "externalDatabase.port"
#   #   value = data.kubernetes_service.yugabyte-tservers.spec.0.port.7.port
#   # }

#   # set {
#   #   name = "externalDatabase.user"
#   #   value = "admin"
#   # }

#   # set {
#   #   name = "externalDatabase.database"
#   #   value = "keycloak-talentsphere"
#   # }

#   # set_sensitive {
#   #   name = "externalDatabase.password"
#   #   value = var.POSTGRES_ADMIN_PASSWORD
#   # }
  
#   set {
#     name = "externalDatabase.host"
#     value = "postgres-postgresql.postgres.svc.cluster.local"
#   }

#   set {
#     name = "externalDatabase.port"
#     value = data.kubernetes_service.postgres.spec.0.port.0.node_port
#   }

#   set {
#     name = "externalDatabase.user"
#     value = var.amplify-lafia-admin
#   }

#   set {
#     name = "externalDatabase.database"
#     value = var.keycloak-namespace
#   }

#   set_sensitive {
#     name = "externalDatabase.password"
#     value = var.POSTGRES_ADMIN_PASSWORD
#   }
# }

# resource "helm_release" "vpa" {
#   name             = "rabbitmq"
#   repository       = "https://charts.bitnami.com/bitnami"
#   chart            = "stevehipwell/vertical-pod-autoscaler"
#   version          = "1.2.0"
#   wait             = true
#   timeout          = 500
#   depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s]
#   values           = ["${file("./charts/vpa/values.yaml")}"]
# }