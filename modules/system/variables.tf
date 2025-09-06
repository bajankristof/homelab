variable "host" {
  type    = string
  default = "192.168.69.69"

  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.host))
    error_message = "The host must be a valid IPv4 address."
  }
}

variable "user" {
  type = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]+$", var.user))
    error_message = "The username can only contain letters, numbers, dots, underscores, and hyphens."
  }
}

variable "password" {
  type      = string
  sensitive = true

  validation {
    condition     = can(regex("[^'\"]", var.password))
    error_message = "The password must not contain single or double quotes."
  }
}

variable "tailscale_auth_key" {
  type      = string
  sensitive = true
}
