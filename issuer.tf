# resource "kubectl_manifest" "cluster_issuer" {
#   yaml_body = <<YAML
# apiVersion: cert-manager.io/v1
# kind: ClusterIssuer
# metadata:
#   name: letsencrypt-prod
# spec:
#   acme:
#     email: hi@parallelscore.com
#     server: https://acme-v02.api.letsencrypt.org/directory
#     privateKeySecretRef:
#       name: issuer-letsencrypt-production
#     solvers:
#       - http01:
#           ingress:
#             class: nginx
# YAML

#   depends_on = [digitalocean_kubernetes_cluster.lafia-k8s]
# }

# resource "kubectl_manifest" "certificate" {
#     yaml_body = <<YAML
# apiVersion: cert-manager.io/v1
# kind: Certificate
# metadata:
#   name: lafia-cert
# spec:
#   secretName: lafia-cert-secret
#   dnsNames:
#   - lafia-backend.${var.dns-name} 
#   - lafia-cms.${var.dns-name}
#   - suresalama-backend.${var.dns-name}
#   - suresalama-cms.${var.dns-name}
#   - fhir-server.${var.dns-name}
#   - keycloak.${var.dns-name}
#   - openhim-console.${var.dns-name}
#   - lafia-dhis2.${var.dns-name}
#   - ant-media.${var.dns-name}
#   issuerRef:
#     name: letsencrypt-production
#     kind: ClusterIssuer
# YAML
# depends_on = [ kubectl_manifest.cluster_issuer ]
# }