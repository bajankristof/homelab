variable "host" {
  type = string
}

variable "port" {
  type    = number
  default = 5432
}

variable "database_name" {
  type = string
}

variable "role_name" {
  type = string
}
