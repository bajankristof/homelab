variable "homelab_ip" {
  type    = string
  default = "192.168.69.69"

  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.homelab_ip))
    error_message = "The address must be a valid IPv4 address."
  }
}

variable "homelab_username" {
  type = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]+$", var.homelab_username))
    error_message = "The username can only contain letters, numbers, dots, underscores, and hyphens."
  }
}

variable "homelab_password" {
  type      = string
  sensitive = true

  validation {
    condition     = can(regex("[^'\"]", var.homelab_password))
    error_message = "The password must not contain single or double quotes."
  }
}

variable "homelab_dns_servers" {
  type    = list(string)
  default = ["1.1.1.1", "9.9.9.9"]

  validation {
    condition     = length(var.homelab_dns_servers) > 0
    error_message = "At least one DNS server is required."
  }
}

variable "tailscale_auth_key" {
  type      = string
  sensitive = true
}
