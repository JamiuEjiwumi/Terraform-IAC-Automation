# # variable "SPACES_ACCESS_ID" {}

# # variable "SPACES_SECRET_KEY" {}

variable "DIGITALOCEAN_TOKEN" {}

# variable "digitalocean_token" {
#     description = "DigitalOcean API token"
#     type        = string
#     default = "dop_v1_786ef9142d26dad64ce959bd4b95d8b64d684aafb745dba48fa1bde24d0df244"
# }

variable "cluster-name" {
  description = "Name of the kubernetes cluster"
  type        = string
  default     = "lafia-k8s-cloak"
}

variable "dns-name" {
  description = "Name of the DNS"
  type = string
  default = "cloakio.dev"
}