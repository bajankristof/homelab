variable "homelab_ip" {
  type    = string
  default = "192.168.69.69"

  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.homelab_ip))
    error_message = "The address must be a valid IPv4 address."
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

variable "cloudflare_tld" {
  type = string
}
