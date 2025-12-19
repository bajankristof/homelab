variable "kubeconfig_path" {
  type    = string
  default = "../../kubeconfig"

  validation {
    condition     = fileexists(var.kubeconfig_path)
    error_message = "The kubeconfig at ${var.kubeconfig_path} does not exist."
  }
}
