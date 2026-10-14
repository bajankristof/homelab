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

variable "storage_class_name" {
  type = string
}

variable "seerr_hostname" {
  type = string
}

variable "seerr_cpu_request" {
  type     = string
  nullable = true
  default  = "100m"
}

variable "seerr_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "seerr_memory_request" {
  type     = string
  nullable = true
  default  = "256Mi"
}

variable "seerr_memory_limit" {
  type     = string
  nullable = true
  default  = "1Gi"
}

variable "plex_host_ip" {
  type    = string
  default = "192.168.69.2"
}

variable "plex_hostname" {
  type = string
}

variable "postgres_fqdn" {
  type = string
}

variable "postgres_port" {
  type    = number
  default = 5432
}

variable "postgres_node_ip" {
  type    = string
  default = "192.168.69.69"

  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.postgres_node_ip))
    error_message = "The address must be a valid IPv4 address."
  }
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
