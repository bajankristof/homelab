variable "name" {
  type = string
}

variable "namespace" {
  type    = string
  default = "default"
}

variable "database_url" {
  type = string
  sensitive = true
}

variable "sql" {
  type = string
  sensitive = true
}

