variable "kubeconfig_path" {
  type    = string
  default = "../../kubeconfig"

  validation {
    condition     = fileexists(var.kubeconfig_path)
    error_message = "The kubeconfig at ${var.kubeconfig_path} does not exist."
  }
}

variable "charts_path" {
  type    = string
  default = "../../charts"
}

variable "network_cidr_block" {
  type    = string
  default = "192.168.69.0/24"

  validation {
    condition     = can(cidrhost(var.network_cidr_block, 1))
    error_message = "The network CIDR block must be a valid CIDR notation."
  }

  validation {
    condition     = can(regex("/24$", var.network_cidr_block))
    error_message = "The network CIDR block must be a /24 subnet."
  }
}

variable "cloudflare_dns_api_token" {
  type      = string
  sensitive = true
}

variable "acme_email" {
  type      = string
  sensitive = true
}

variable "traefik_hostname" {
  type = string
}

variable "traefik_cpu_request" {
  type     = string
  nullable = true
  default  = "100m"
}

variable "traefik_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "traefik_memory_request" {
  type     = string
  nullable = true
  default  = "96Mi"
}

variable "traefik_memory_limit" {
  type     = string
  nullable = true
  default  = "256Mi"
}

variable "adguard_cpu_request" {
  type     = string
  nullable = true
  default  = null
}

variable "adguard_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "adguard_memory_request" {
  type     = string
  nullable = true
  default  = "128Mi"
}

variable "adguard_memory_limit" {
  type     = string
  nullable = true
  default  = "384Mi"
}

variable "metallb_cpu_request" {
  type     = string
  nullable = true
  default  = "25m"
}

variable "metallb_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "metallb_memory_request" {
  type     = string
  nullable = true
  default  = "32Mi"
}

variable "metallb_memory_limit" {
  type     = string
  nullable = true
  default  = "256Mi"
}
