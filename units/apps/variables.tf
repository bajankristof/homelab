variable "homelab_ip" {
  type    = string
  default = "192.168.69.69"

  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.homelab_ip))
    error_message = "The address must be a valid IPv4 address."
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

variable "kubeconfig_path" {
  type = string

  validation {
    condition     = fileexists(var.kubeconfig_path)
    error_message = "The kubeconfig at ${var.kubeconfig_path} does not exist."
  }
}

variable "postgres_fqdn" {
  type = string
}

variable "postgres_port" {
  type    = number
  default = 5432
}

variable "postgres_node_port" {
  type = number
}

variable "postgres_root_user" {
  type = string
}

variable "postgres_root_password" {
  type      = string
  sensitive = true
}

variable "pocket_id_url" {
  type = string
}

variable "pocket_id_api_key" {
  type      = string
  sensitive = true
}

variable "cloudflare_tld" {
  type = string
}
