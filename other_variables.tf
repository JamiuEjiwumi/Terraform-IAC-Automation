# variable "DIGITALOCEAN_TOKEN" {}

variable "POSTGRES_ADMIN_PASSWORD" {}



variable "ingress-namespace" {
  description = "Namespace name for ingress deployment"
  type        = string
  default     = "ingress-nginx"
}

variable "postgres-namespace" {
  description = "Namespace name for Postgresql deployment"
  type        = string
  default     = "postgres"
}

variable "postgres-service-name" {
  description = "Name of the postgres service"
  type        = string
  default     = "postgres-postgresql"
}

variable "lafia-admin" {
  description = "Lafia Admin username"
  type        = string
  default     = "lafiaadmin"
}

variable "admin-last-name" {
  description = "Admin's Last Name"
  type        = string
  default     = "Lafia"
}

variable "LAFIA_ADMIN_PASSWORD" {
  description = "Name of the lafia service"
  type        = string
}


variable "rabbitmq-namespace" {
  description = "Namespace name for rabbitmq deployment"
  type        = string
  default     = "rabbitmq"
}

variable "apisix_namespace" {
  description = "Namespace name for rabbitmq deployment"
  type        = string
  default     = "apisix"
}

variable "cert-manager-namespace" {
  description = "Namespace for the cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "name" {
  type = string
  default = "lafia-k8s"
}

variable "node_count" {
    type = number
    default = 3 
}

variable "region" {
  type = string
  default = "nyc1"
}

variable "image" {
  type = string
  default = "registry.digitalocean.com/lafia-dcr/lafia-service:latest"
}

variable "port" {
  type = number
  default = "9500"
}

variable "redis_namespace" {
  type    = string
  default = "default"
}

variable "redis_host" {
  type    = string
  default = "redis-host"
}

variable "redis_port" {
  type    = string
  default = "6379"
}

variable "redis_username" {
  type    = string
  default = "redis"
}

variable "redis_password" {
  type    = string
  default = "password123"
}

variable "rabbitmq_erlang_cookie" {
  description = "Erlang cookie value for RabbitMQ"
  type        = string
  default     = "JA4ohRPMaaVil2L5DAPDS9dA3xqRXiJl"
}

variable "etcd_pod_name" {
  description = "apisix-etcd deployment"
  type        = string
  default     = "apisix-etcd"
}