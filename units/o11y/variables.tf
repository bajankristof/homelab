variable "kubeconfig_path" {
  type    = string
  default = "../../kubeconfig"

  validation {
    condition     = fileexists(var.kubeconfig_path)
    error_message = "The kubeconfig at ${var.kubeconfig_path} does not exist."
  }
}

variable "storage_class_name" {
  type = string
}

variable "pocket_id_base_url" {
  type = string
}

variable "pocket_id_api_key" {
  type      = string
  sensitive = true
}

variable "grafana_hostname" {
  type = string
}

variable "grafana_base_url" {
  type = string
}

variable "grafana_admin_username" {
  type    = string
  default = "admin"
}

variable "grafana_cpu_request" {
  type     = string
  nullable = true
  default  = "100m"
}

variable "grafana_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "grafana_memory_request" {
  type     = string
  nullable = true
  default  = "384Mi"
}

variable "grafana_memory_limit" {
  type     = string
  nullable = true
  default  = "1Gi"
}

variable "oidc_auth_url" {
  type = string
}

variable "oidc_token_url" {
  type = string
}

variable "oidc_userinfo_url" {
  type = string
}

variable "smtp_host" {
  type = string
}

variable "smtp_port" {
  type = number
}

variable "smtp_username" {
  type = string
}

variable "smtp_password" {
  type      = string
  sensitive = true
}

variable "smtp_from_address" {
  type = string
}

variable "alloy_cpu_request" {
  type     = string
  nullable = true
  default  = null
}

variable "alloy_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "alloy_memory_request" {
  type     = string
  nullable = true
  default  = "128Mi"
}

variable "alloy_memory_limit" {
  type     = string
  nullable = true
  default  = "512Mi"
}

variable "victoria_metrics_cpu_request" {
  type     = string
  nullable = true
  default  = null
}

variable "victoria_metrics_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "victoria_metrics_memory_request" {
  type     = string
  nullable = true
  default  = "256Mi"
}

variable "victoria_metrics_memory_limit" {
  type     = string
  nullable = true
  default  = "768Mi"
}

variable "victoria_metrics_retention_days" {
  type    = number
  default = 90
}

variable "victoria_logs_cpu_request" {
  type     = string
  nullable = true
  default  = null
}

variable "victoria_logs_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "victoria_logs_memory_request" {
  type     = string
  nullable = true
  default  = "128Mi"
}

variable "victoria_logs_memory_limit" {
  type     = string
  nullable = true
  default  = "512Mi"
}

variable "victoria_logs_retention_days" {
  type    = number
  default = 30
}

variable "kube_state_metrics_cpu_request" {
  type     = string
  nullable = true
  default  = null
}

variable "kube_state_metrics_cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "kube_state_metrics_memory_request" {
  type     = string
  nullable = true
  default  = "64Mi"
}

variable "kube_state_metrics_memory_limit" {
  type     = string
  nullable = true
  default  = "256Mi"
}
