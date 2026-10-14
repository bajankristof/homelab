variable "grafana_base_url" {
  type = string
}

variable "grafana_admin_username" {
  type    = string
  default = "admin"
}

variable "grafana_admin_password" {
  type      = string
  sensitive = true
}

variable "grafana_org_id" {
  type    = number
  default = 1
}

variable "prometheus_datasource_uid" {
  type    = string
  default = "prometheus"
}

variable "alert_email" {
  type = string

  validation {
    condition     = can(regex("^[^@]+@[^@]+\\.[^@]+$", var.alert_email))
    error_message = "The alert_email must be a valid email address."
  }
}
