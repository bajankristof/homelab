variable "pocket_id_base_url" {
  type = string
}

variable "pocket_id_api_key" {
  type      = string
  sensitive = true
}

variable "grafana_base_url" {
  type = string
}
