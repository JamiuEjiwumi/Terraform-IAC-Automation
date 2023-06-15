# resource "kubernetes_stateful_set" "apisix_etcd" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s
#     ]
#   metadata {
#     name      = "apisix-etcd"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix-etcd"
#       "app.kubernetes.io/name"     = "apisix-etcd"
#     }
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         "app.kubernetes.io/instance" = "apisix-etcd"
#         "app.kubernetes.io/name"     = "apisix-etcd"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           "app.kubernetes.io/instance" = "apisix-etcd"
#           "app.kubernetes.io/name"     = "apisix-etcd"
#         }
#       }

#       spec {
#         container {
#           name  = "apisix-etcd"
#           image = "docker.io/bitnami/etcd:3.5.1-debian-10-r31"

#           port {
#             name          = "client"
#             container_port = 2379
#             protocol      = "TCP"
#           }

#           port {
#             name          = "peer"
#             container_port = 2380
#             protocol      = "TCP"
#           }

#           env {
#             name = "BITNAMI_DEBUG"
#             value = "false"
#           }

#           env {
#             name = "MY_POD_IP"
#             value_from {
#               field_ref {
#                 api_version = "v1"
#                 field_path  = "status.podIP"
#               }
#             }
#           }

#           env {
#             name = "MY_POD_NAME"
#             value_from {
#               field_ref {
#                 api_version = "v1"
#                 field_path  = "metadata.name"
#               }
#             }
#           }

#           env {
#             name  = "ETCDCTL_API"
#             value = "3"
#           }

#           env {
#             name  = "ETCD_ON_K8S"
#             value = "yes"
#           }

#           env {
#             name  = "ETCD_START_FROM_SNAPSHOT"
#             value = "no"
#           }

#           env {
#             name  = "ETCD_DISASTER_RECOVERY"
#             value = "no"
#           }

#           env {
#             name  = "ETCD_NAME"
#             value = "${var.etcd_pod_name}"
#           }

#           env {
#             name  = "ETCD_DATA_DIR"
#             value = "/bitnami/etcd/data"
#           }

#           env {
#             name  = "ETCD_LOG_LEVEL"
#             value = "info"
#           }

#           env {
#             name  = "ALLOW_NONE_AUTHENTICATION"
#             value = "yes"
#           }

#           env {
#             name  = "ETCD_ADVERTISE_CLIENT_URLS"
#             value = "http://${var.etcd_pod_name}.apisix-etcd-headless.default.svc.cluster.local:2379,http://apisix-etcd.default.svc.cluster.local:2379"
#           }

#           env {
#             name  = "ETCD_LISTEN_CLIENT_URLS"
#             value = "http://0.0.0.0:2379"
#           }

#           env {
#             name  = "ETCD_INITIAL_ADVERTISE_PEER_URLS"
#             value = "http://${var.etcd_pod_name}.apisix-etcd-headless.default.svc.cluster.local:2380"
#           }

#           env {
#             name  = "ETCD_LISTEN_PEER_URLS"
#             value = "http://0.0.0.0:2380"
#           }

#           volume_mount {
#             name       = "data"
#             mount_path = "/bitnami/etcd"
#           }

#           liveness_probe {
#             exec {
#               command = ["/opt/bitnami/scripts/etcd/healthcheck.sh"]
#             }
#             initial_delay_seconds = 60
#             timeout_seconds       = 5
#             period_seconds        = 30
#             success_threshold     = 1
#             failure_threshold     = 5
#           }

#           readiness_probe {
#             exec {
#               command = ["/opt/bitnami/scripts/etcd/healthcheck.sh"]
#             }
#             initial_delay_seconds = 60
#             timeout_seconds       = 5
#             period_seconds        = 10
#             success_threshold     = 1
#             failure_threshold     = 5
#           }

#           termination_message_path    = "/dev/termination-log"
#           termination_message_policy = "File"
#           image_pull_policy          = "IfNotPresent"

#           security_context {
#             run_as_user    = 1001
#             run_as_non_root = true
#           }
#         }

#         restart_policy                  = "Always"
#         termination_grace_period_seconds = 30
#         dns_policy                      = "ClusterFirst"
#         service_account_name            = "default"

#         security_context {
#           fs_group = 1001
#         }

#         affinity {
#           pod_anti_affinity {
#             preferred_during_scheduling_ignored_during_execution {
#               weight = 1

#               pod_affinity_term {
#                 label_selector {
#                   match_labels = {
#                     "app.kubernetes.io/instance" = "apisix-etcd"
#                     "app.kubernetes.io/name"     = "apisix-etcd"
#                   }
#                 }
#                 namespaces    = ["default"]
#                 topology_key  = "kubernetes.io/hostname"
#               }
#             }
#           }
#         }

#         scheduler_name = "default-scheduler"
#       }
#     }

#     volume_claim_template {
#       metadata {
#         name = "data"
#       }

#       spec {
#         access_modes = ["ReadWriteOnce"]

#         resources {
#           requests = {
#             storage = "1Gi"
#           }
#         }

#         # volume_mode = "Filesystem"
#       }
#     }

#     service_name           = "apisix-etcd-headless"
#     pod_management_policy = "Parallel"

#     update_strategy {
#       type = "RollingUpdate"
#     }

#     revision_history_limit = 10
#   }
# }

# resource "kubernetes_service" "apisix_etcd_headless" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s
#     ]
#   metadata {
#     name      = "apisix-etcd-headless"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix-etcd"
#       "app.kubernetes.io/name"     = "apisix-etcd"
#     }

#     annotations = {
#       "meta.helm.sh/release-name"      = "apisix-etcd"
#       "meta.helm.sh/release-namespace" = "default"
#       "service.alpha.kubernetes.io/tolerate-unready-endpoints" = "true"
#     }
#   }

#   spec {
#     port {
#       name       = "client"
#       protocol   = "TCP"
#       port       = 2379
#       target_port = "client"
#     }

#     port {
#       name       = "peer"
#       protocol   = "TCP"
#       port       = 2380
#       target_port = "peer"
#     }

#     selector = {
#       "app.kubernetes.io/instance" = "apisix-etcd"
#       "app.kubernetes.io/name"     = "apisix-etcd"
#     }

#     cluster_ip                   = "None"
#     cluster_ips                  = ["None"]
#     type                         = "ClusterIP"
#     session_affinity             = "None"
#     publish_not_ready_addresses  = true
#     ip_families                  = ["IPv4"]
#     ip_family_policy             = "SingleStack"
#   }
# }

# resource "kubernetes_service" "apisix_etcd" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_stateful_set.apisix_etcd
#     ]
#   metadata {
#     name      = "apisix-etcd"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix-etcd"
#       "app.kubernetes.io/name"     = "apisix-etcd"
#     }

#     annotations = {
#       "meta.helm.sh/release-name"      = "apisix-etcd"
#       "meta.helm.sh/release-namespace" = "default"
#     }
#   }

#   spec {
#     port {
#       name       = "client"
#       protocol   = "TCP"
#       port       = 2379
#       target_port = "client"
#     }

#     port {
#       name       = "peer"
#       protocol   = "TCP"
#       port       = 2380
#       target_port = "peer"
#     }

#     selector = {
#       "app.kubernetes.io/instance" = "apisix-etcd"
#       "app.kubernetes.io/name"     = "apisix-etcd"
#     }

#     type = "ClusterIP"
#   }
# }



# resource "kubernetes_deployment" "apisix" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s
#     ]
#   metadata {
#     name      = "apisix"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix"
#       "app.kubernetes.io/name"     = "apisix"
#       "app.kubernetes.io/version"  = "2.10.0"
#     }
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         "app.kubernetes.io/instance" = "apisix"
#         "app.kubernetes.io/name"     = "apisix"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           "app.kubernetes.io/instance" = "apisix"
#           "app.kubernetes.io/name"     = "apisix"
#         }
#       }

#       spec {
#         volume {
#           name = "apisix-config"

#           config_map {
#             name         = "apisix"
#             default_mode = "0420"
#           }
#         }

#         init_container {
#           name  = "wait-etcd"
#           image = "busybox:1.28"

#           command = [
#             "sh",
#             "-c",
#             "until nc -z apisix-etcd.default.svc.cluster.local 2379; do echo waiting for etcd $(date); sleep 2; done;"
#           ]

#           resources {}
#           termination_message_path   = "/dev/termination-log"
#           termination_message_policy = "File"
#           image_pull_policy         = "IfNotPresent"
#         }

#         container {
#           name  = "apisix"
#           image = "apache/apisix:2.10.0-alpine"

#           port {
#             name          = "http"
#             container_port = 9080
#             protocol      = "TCP"
#           }

#           port {
#             name          = "tls"
#             container_port = 9443
#             protocol      = "TCP"
#           }

#           port {
#             name          = "admin"
#             container_port = 9180
#             protocol      = "TCP"
#           }

#           resources {}

#           volume_mount {
#             name      = "apisix-config"
#             mount_path = "/usr/local/apisix/conf/config.yaml"
#             sub_path   = "config.yaml"
#           }

#           readiness_probe {
#             tcp_socket {
#               port = 9080
#             }

#             initial_delay_seconds = 10
#             timeout_seconds       = 1
#             period_seconds        = 10
#             success_threshold     = 1
#             failure_threshold     = 6
#           }

#           lifecycle {
#             pre_stop {
#               exec {
#                 command = [
#                   "/bin/sh",
#                   "-c",
#                   "sleep 30"
#                 ]
#               }
#             }
#           }

#           termination_message_path   = "/dev/termination-log"
#           termination_message_policy = "File"
#           image_pull_policy         = "IfNotPresent"
#         }

#         restart_policy                      = "Always"
#         termination_grace_period_seconds    = 30
#         dns_policy                          = "ClusterFirst"
#         scheduler_name                      = "default-scheduler"
#         # security_context                    = {}
#       }
#     }

#     strategy {
#       type = "RollingUpdate"

#       rolling_update {
#         max_unavailable = "25%"
#         max_surge       = "25%"
#       }
#     }

#     revision_history_limit         = 10
#     progress_deadline_seconds      = 600
#   }
# }

# resource "kubernetes_config_map" "apisix" {
#   metadata {
#     name      = "apisix"
#     namespace = "default"
#   }

#   data = {
#     "config.yaml" = <<-EOT
# #

# # Licensed to the Apache Software Foundation (ASF) under one or more

# # contributor license agreements. See the NOTICE file distributed with

# # this work for additional information regarding copyright ownership.

# # The ASF licenses this file to You under the Apache License, Version 2.0

# # (the "License"); you may not use this file except in compliance with

# # the License. You may obtain a copy of the License at

# #

# #     http://www.apache.org/licenses/LICENSE-2.0

# #

# # Unless required by applicable law or agreed to in writing, software

# # distributed under the License is distributed on an "AS IS" BASIS,

# # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

# # See the License for the specific language governing permissions and

# # limitations under the License.

# #

# apisix:
#   node_listen: 9080             # APISIX listening port
#   enable_heartbeat: true
#   enable_admin: true
#   enable_admin_cors: true
#   enable_debug: false
#   enable_dev_mode: false          # Sets nginx worker_processes to 1 if set to true
#   enable_reuseport: true          # Enable nginx SO_REUSEPORT switch if set to true.
#   enable_ipv6: true
#   config_center: etcd             # etcd: use etcd to store the config value
#                                   # yaml: fetch the config value from local yaml file `/your_path/conf/apisix.yaml`


#   #proxy_protocol:                 # Proxy Protocol configuration
#   #  listen_http_port: 9181        # The port with proxy protocol for http, it differs from node_listen and port_admin.
#                                   # This port can only receive http request with proxy protocol, but node_listen & port_admin
#                                   # can only receive http request. If you enable proxy protocol, you must use this port to
#                                   # receive http request with proxy protocol
#   #  listen_https_port: 9182       # The port with proxy protocol for https
#   #  enable_tcp_pp: true           # Enable the proxy protocol for tcp proxy, it works for stream_proxy.tcp option
#   #  enable_tcp_pp_to_upstream: true # Enables the proxy protocol to the upstream server

#   proxy_cache:                     # Proxy Caching configuration
#     cache_ttl: 10s                 # The default caching time if the upstream does not specify the cache time
#     zones:                         # The parameters of a cache
#     - name: disk_cache_one         # The name of the cache, administrator can be specify
#                                   # which cache to use by name in the admin api
#       memory_size: 50m             # The size of shared memory, it's used to store the cache index
#       disk_size: 1G                # The size of disk, it's used to store the cache data
#       disk_path: "/tmp/disk_cache_one" # The path to store the cache data
#       cache_levels: "1:2"           # The hierarchy levels of a cache
#   #  - name: disk_cache_two
#   #    memory_size: 50m
#   #    disk_size: 1G
#   #    disk_path: "/tmp/disk_cache_two"
#   #    cache_levels: "1:2"

#   allow_admin:                  # http://nginx.org/en/docs/http/ngx_http_access_module.html#allow
#     - 127.0.0.1/24
#   #   - "::/64"
#   port_admin: 9180

#   # Default token when use API to call for Admin API.
#   # *NOTE*: Highly recommended to modify this value to protect APISIX's Admin API.
#   # Disabling this configuration item means that the Admin API does not
#   # require any authentication.
#   admin_key:
#     # admin: can everything for configuration data
#     - name: "admin"
#       key: edd1c9f034335f136f87ad84b625c8f1
#       role: admin
#     # viewer: only can view configuration data
#     - name: "viewer"
#       key: 4054f7cf07e344346cd3f287985e76a2
#       role: viewer
#   router:
#     http: 'radixtree_uri'         # radixtree_uri: match route by uri(base on radixtree)
#                                   # radixtree_host_uri: match route by host + uri(base on radixtree)
#     ssl: 'radixtree_sni'          # radixtree_sni: match route by SNI(base on radixtree)
#   # dns_resolver:
#   #
#   #   - 127.0.0.1
#   #
#   #   - 172.20.0.10
#   #
#   #   - 114.114.114.114
#   #
#   #   - 223.5.5.5
#   #
#   #   - 1.1.1.1
#   #
#   #   - 8.8.8.8
#   #
#   dns_resolver_valid: 30
#   resolver_timeout: 5
#   ssl:
#     enable: false
#     enable_http2: true
#     listen_port: 9443
#     ssl_protocols: "TLSv1 TLSv1.1 TLSv1.2 TLSv1.3"
#     ssl_ciphers: "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA256:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA"

# nginx_config:                     # config for render the template to
# genarate nginx.conf
#   error_log: "/dev/stderr"
#   error_log_level: "warn"         # warn,error
#   worker_rlimit_nofile: 20480     # the number of files a worker process can open, should be larger than worker_connections
#   event:
#     worker_connections: 10620
#   http:
#     access_log: "/dev/stdout"
#     keepalive_timeout: 60s         # timeout during which a keep-alive client connection will stay open on the server side.
#     client_header_timeout: 60s     # timeout for reading client request header, then 408 (Request Time-out) error is returned to the client
#     client_body_timeout: 60s       # timeout for reading client request body, then 408 (Request Time-out) error is returned to the client
#     send_timeout: 10s              # timeout for transmitting a response to the client.then the connection is closed
#     underscores_in_headers: "on"   # default enables the use of underscores in client request header fields
#     real_ip_header: "X-Real-IP"    # http://nginx.org/en/docs/http/ngx_http_realip_module.html#real_ip_header
#     real_ip_from:                  # http://nginx.org/en/docs/http/ngx_http_realip_module.html#set_real_ip_from
#       - 127.0.0.1
#       - 'unix:'

# etcd:
#   host:                                 # it's possible to define multiple etcd hosts addresses of the same etcd cluster.
#     - "http://apisix-etcd.default.svc.cluster.local:2379"
#   prefix: "/apisix"     # apisix configurations prefix
#   timeout: 30   # 30 seconds
# plugins:                          # plugin list
#   - api-breaker
#   - authz-keycloak
#   - basic-auth
#   - batch-requests
#   - consumer-restriction
#   - cors
#   - echo
#   - fault-injection
#   - grpc-transcode
#   - hmac-auth
#   - http-logger
#   - ip-restriction
#   - ua-restriction
#   - jwt-auth
#   - kafka-logger
#   - key-auth
#   - limit-conn
#   - limit-count
#   - limit-req
#   - node-status
#   - openid-connect
#   - authz-casbin
#   - prometheus
#   - proxy-cache
#   - proxy-mirror
#   - proxy-rewrite
#   - redirect
#   - referer-restriction
#   - request-id
#   - request-validation
#   - response-rewrite
#   - serverless-post-function
#   - serverless-pre-function
#   - sls-logger
#   - syslog
#   - tcp-logger
#   - udp-logger
#   - uri-blocker
#   - wolf-rbac
#   - zipkin
#   - server-info
#   - traffic-split
#   - gzip
#   - real-ip
# stream_plugins:
#   - mqtt-proxy
#   - ip-restriction
#   - limit-conn
# plugin_attr:
#   server-info:
#     report_interval: 60
#     report_ttl: 3600
#   "#,
# })

# resource "kubernetes_config_map" "apisix_config" {
#   metadata {
#     name      = "apisix"
#     namespace = "default"
#   }

#   data = {
#     "config.yaml" = <<-EOT
#       data = {
#     "config.yaml" = <<-EOT
# #

# # Licensed to the Apache Software Foundation (ASF) under one or more

# # contributor license agreements. See the NOTICE file distributed with

# # this work for additional information regarding copyright ownership.

# # The ASF licenses this file to You under the Apache License, Version 2.0

# # (the "License"); you may not use this file except in compliance with

# # the License. You may obtain a copy of the License at

# #

# #     http://www.apache.org/licenses/LICENSE-2.0

# #

# # Unless required by applicable law or agreed to in writing, software

# # distributed under the License is distributed on an "AS IS" BASIS,

# # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

# # See the License for the specific language governing permissions and

# # limitations under the License.

# #

# apisix:
#   node_listen: 9080             # APISIX listening port
#   enable_heartbeat: true
#   enable_admin: true
#   enable_admin_cors: true
#   enable_debug: false
#   enable_dev_mode: false          # Sets nginx worker_processes to 1 if set to true
#   enable_reuseport: true          # Enable nginx SO_REUSEPORT switch if set to true.
#   enable_ipv6: true
#   config_center: etcd             # etcd: use etcd to store the config value
#                                   # yaml: fetch the config value from local yaml file `/your_path/conf/apisix.yaml`


#   #proxy_protocol:                 # Proxy Protocol configuration
#   #  listen_http_port: 9181        # The port with proxy protocol for http, it differs from node_listen and port_admin.
#                                   # This port can only receive http request with proxy protocol, but node_listen & port_admin
#                                   # can only receive http request. If you enable proxy protocol, you must use this port to
#                                   # receive http request with proxy protocol
#   #  listen_https_port: 9182       # The port with proxy protocol for https
#   #  enable_tcp_pp: true           # Enable the proxy protocol for tcp proxy, it works for stream_proxy.tcp option
#   #  enable_tcp_pp_to_upstream: true # Enables the proxy protocol to the upstream server

#   proxy_cache:                     # Proxy Caching configuration
#     cache_ttl: 10s                 # The default caching time if the upstream does not specify the cache time
#     zones:                         # The parameters of a cache
#     - name: disk_cache_one         # The name of the cache, administrator can be specify
#                                   # which cache to use by name in the admin api
#       memory_size: 50m             # The size of shared memory, it's used to store the cache index
#       disk_size: 1G                # The size of disk, it's used to store the cache data
#       disk_path: "/tmp/disk_cache_one" # The path to store the cache data
#       cache_levels: "1:2"           # The hierarchy levels of a cache
#   #  - name: disk_cache_two
#   #    memory_size: 50m
#   #    disk_size: 1G
#   #    disk_path: "/tmp/disk_cache_two"
#   #    cache_levels: "1:2"

#   allow_admin:                  # http://nginx.org/en/docs/http/ngx_http_access_module.html#allow
#     - 127.0.0.1/24
#   #   - "::/64"
#   port_admin: 9180

#   # Default token when use API to call for Admin API.
#   # *NOTE*: Highly recommended to modify this value to protect APISIX's Admin API.
#   # Disabling this configuration item means that the Admin API does not
#   # require any authentication.
#   admin_key:
#     # admin: can everything for configuration data
#     - name: "admin"
#       key: edd1c9f034335f136f87ad84b625c8f1
#       role: admin
#     # viewer: only can view configuration data
#     - name: "viewer"
#       key: 4054f7cf07e344346cd3f287985e76a2
#       role: viewer
#   router:
#     http: 'radixtree_uri'         # radixtree_uri: match route by uri(base on radixtree)
#                                   # radixtree_host_uri: match route by host + uri(base on radixtree)
#     ssl: 'radixtree_sni'          # radixtree_sni: match route by SNI(base on radixtree)
#   # dns_resolver:
#   #
#   #   - 127.0.0.1
#   #
#   #   - 172.20.0.10
#   #
#   #   - 114.114.114.114
#   #
#   #   - 223.5.5.5
#   #
#   #   - 1.1.1.1
#   #
#   #   - 8.8.8.8
#   #
#   dns_resolver_valid: 30
#   resolver_timeout: 5
#   ssl:
#     enable: false
#     enable_http2: true
#     listen_port: 9443
#     ssl_protocols: "TLSv1 TLSv1.1 TLSv1.2 TLSv1.3"
#     ssl_ciphers: "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA256:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA"

# nginx_config:                     # config for render the template to
# genarate nginx.conf
#   error_log: "/dev/stderr"
#   error_log_level: "warn"         # warn,error
#   worker_rlimit_nofile: 20480     # the number of files a worker process can open, should be larger than worker_connections
#   event:
#     worker_connections: 10620
#   http:
#     access_log: "/dev/stdout"
#     keepalive_timeout: 60s         # timeout during which a keep-alive client connection will stay open on the server side.
#     client_header_timeout: 60s     # timeout for reading client request header, then 408 (Request Time-out) error is returned to the client
#     client_body_timeout: 60s       # timeout for reading client request body, then 408 (Request Time-out) error is returned to the client
#     send_timeout: 10s              # timeout for transmitting a response to the client.then the connection is closed
#     underscores_in_headers: "on"   # default enables the use of underscores in client request header fields
#     real_ip_header: "X-Real-IP"    # http://nginx.org/en/docs/http/ngx_http_realip_module.html#real_ip_header
#     real_ip_from:                  # http://nginx.org/en/docs/http/ngx_http_realip_module.html#set_real_ip_from
#       - 127.0.0.1
#       - 'unix:'

# etcd:
#   host:                                 # it's possible to define multiple etcd hosts addresses of the same etcd cluster.
#     - "http://apisix-etcd.default.svc.cluster.local:2379"
#   prefix: "/apisix"     # apisix configurations prefix
#   timeout: 30   # 30 seconds
# plugins:                          # plugin list
#   - api-breaker
#   - authz-keycloak
#   - basic-auth
#   - batch-requests
#   - consumer-restriction
#   - cors
#   - echo
#   - fault-injection
#   - grpc-transcode
#   - hmac-auth
#   - http-logger
#   - ip-restriction
#   - ua-restriction
#   - jwt-auth
#   - kafka-logger
#   - key-auth
#   - limit-conn
#   - limit-count
#   - limit-req
#   - node-status
#   - openid-connect
#   - authz-casbin
#   - prometheus
#   - proxy-cache
#   - proxy-mirror
#   - proxy-rewrite
#   - redirect
#   - referer-restriction
#   - request-id
#   - request-validation
#   - response-rewrite
#   - serverless-post-function
#   - serverless-pre-function
#   - sls-logger
#   - syslog
#   - tcp-logger
#   - udp-logger
#   - uri-blocker
#   - wolf-rbac
#   - zipkin
#   - server-info
#   - traffic-split
#   - gzip
#   - real-ip
# stream_plugins:
#   - mqtt-proxy
#   - ip-restriction
#   - limit-conn
# plugin_attr:
#   server-info:
#     report_interval: 60
#     report_ttl: 3600
#   "#,
# })
#     EOT
#   }
# }

# resource "kubernetes_service" "apisix_admin" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s
#     ]
#   metadata {
#     name      = "apisix-admin"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix"
#       "app.kubernetes.io/name"     = "apisix"
#       "app.kubernetes.io/version"  = "2.10.0"
#     }
#   }

#   spec {
#     selector = {
#       "app.kubernetes.io/instance" = "apisix"
#       "app.kubernetes.io/name"     = "apisix"
#     }

#     port {
#       name       = "apisix-admin"
#       protocol   = "TCP"
#       port       = 9180
#       target_port = 9180
#     }

#     type = "ClusterIP"
#   }
# }

# resource "kubernetes_service" "apisix_gateway" {
#   metadata {
#     name      = "apisix-gateway"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix"
#       "app.kubernetes.io/name"     = "apisix"
#       "app.kubernetes.io/version"  = "2.10.0"
#     }
#   }

#   spec {
#     selector = {
#       "app.kubernetes.io/instance" = "apisix"
#       "app.kubernetes.io/name"     = "apisix"
#     }

#     port {
#       name       = "apisix-gateway"
#       protocol   = "TCP"
#       port       = 80
#       target_port = 9080
#       node_port   = 31684
#     }

#     type                   = "NodePort"
#     session_affinity       = "None"
#     external_traffic_policy = "Cluster"
#   }
# }


# resource "kubernetes_deployment" "apisix_dashboard" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s
#     ]
#   metadata {
#     name      = "apisix-dashboard"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix-dashboard"
#       "app.kubernetes.io/name"     = "apisix-dashboard"
#       "app.kubernetes.io/version"  = "2.9.0"
#     }
#   }

#   spec {
#     replicas = 1

#     selector {
#       match_labels = {
#         "app.kubernetes.io/instance" = "apisix-dashboard"
#         "app.kubernetes.io/name"     = "apisix-dashboard"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           "app.kubernetes.io/instance" = "apisix-dashboard"
#           "app.kubernetes.io/name"     = "apisix-dashboard"
#         }
#       }

#       spec {
#         volume {
#           name = "apisix-dashboard-config"

#           config_map {
#             name         = "apisix-dashboard"
#             default_mode = "0420"
#           }
#         }

#         container {
#           name  = "apisix-dashboard"
#           image = "apache/apisix-dashboard:2.9.0"

#           port {
#             name          = "http"
#             container_port = 9000
#             protocol      = "TCP"
#           }

#           volume_mount {
#             name       = "apisix-dashboard-config"
#             mount_path = "/usr/local/apisix-dashboard/conf/conf.yaml"
#             sub_path   = "conf.yaml"
#           }

#           liveness_probe {
#             http_get {
#               path   = "/ping"
#               port   = "http"
#               scheme = "HTTP"
#             }
#             timeout_seconds      = 1
#             period_seconds       = 10
#             success_threshold    = 1
#             failure_threshold    = 3
#           }

#           readiness_probe {
#             http_get {
#               path   = "/ping"
#               port   = "http"
#               scheme = "HTTP"
#             }
#             timeout_seconds      = 1
#             period_seconds       = 10
#             success_threshold    = 1
#             failure_threshold    = 3
#           }

#           termination_message_path   = "/dev/termination-log"
#           termination_message_policy = "File"
#           image_pull_policy         = "IfNotPresent"

#         #   security_context {}

#         #   resources {}

#         #   env {}

#         #   lifecycle {}

#         #   ports {}

#         #   readiness_probe {}

#         #   liveness_probe {}
#         }

#         restart_policy                     = "Always"
#         termination_grace_period_seconds   = 30
#         dns_policy                         = "ClusterFirst"
#         service_account_name               = "apisix-dashboard"
#         # service_account                    = "apisix-dashboard"
#         # security_context                   = {}
#         scheduler_name                     = "default-scheduler"
#       }
#     }

#     strategy {
#       type = "RollingUpdate"

#       rolling_update {
#         max_unavailable = "25%"
#         max_surge       = "25%"
#       }
#     }

#     revision_history_limit          = 10
#     progress_deadline_seconds       = 600
#   }
# }


# resource "kubernetes_service" "apisix_dashboard" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s, kubernetes_deployment.apisix_dashboard
#     ]
#   metadata {
#     name      = "apisix-dashboard"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix-dashboard"
#       "app.kubernetes.io/name"     = "apisix-dashboard"
#       "app.kubernetes.io/version"  = "2.9.0"
#     }
#   }

#   spec {
#     port {
#       name          = "http"
#       protocol      = "TCP"
#       port          = 80
#       target_port   = "http"
#     }

#     selector = {
#       "app.kubernetes.io/instance" = "apisix-dashboard"
#       "app.kubernetes.io/name"     = "apisix-dashboard"
#     }

#     type = "ClusterIP"
#   }
# }

# resource "kubernetes_config_map" "apisix_dashboard" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s
#     ]
#   metadata {
#     name      = "apisix-dashboard"
#     namespace = "default"

#     labels = {
#       "app.kubernetes.io/instance" = "apisix-dashboard"
#       "app.kubernetes.io/name"     = "apisix-dashboard"
#       "app.kubernetes.io/version"  = "2.9.0"
#     }
#   }

#   data = {
#     "conf.yaml" = <<-EOT
#       conf:
#         listen:
#           host: 0.0.0.0
#           port: 9000
#         etcd:
#           endpoints:
#             - apisix-etcd:2379
#         log:
#           error_log:
#             level: warn
#             file_path: /dev/stderr
#           access_log:
#             file_path: /dev/stdout
#       authentication:
#         secert: secert
#         expire_time: 3600
#         users:
#           - username: admin
#             password: admin
#     EOT
#   }
# }

# resource "kubernetes_service_account" "apisix_dashboard" {
#     depends_on       = [digitalocean_kubernetes_cluster.lafia-k8s
#     ]
#   metadata {
#     name      = "apisix-dashboard"
#     namespace = "default"
#   }
# }