variable "kubeconfig_path" {
  type = string

  validation {
    condition     = fileexists(var.kubeconfig_path)
    error_message = "The kubeconfig at ${var.kubeconfig_path} does not exist."
  }
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

variable "acme_email" {
  type      = string
  sensitive = true
}

variable "cloudflare_tld" {
  type = string
}

variable "cloudflare_dns_api_token" {
  type      = string
  sensitive = true
}
