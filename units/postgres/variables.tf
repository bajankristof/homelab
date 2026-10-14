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
  type    = string
  default = ""
}

variable "cpu_request" {
  type     = string
  nullable = true
  default  = "250m"
}

variable "cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "memory_request" {
  type     = string
  nullable = true
  default  = "384Mi"
}

variable "memory_limit" {
  type     = string
  nullable = true
  default  = "1Gi"
}
