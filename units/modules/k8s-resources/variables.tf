variable "cpu_request" {
  type     = string
  nullable = true
  default  = null
}

variable "memory_request" {
  type     = string
  nullable = true
  default  = null
}

variable "cpu_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "memory_limit" {
  type     = string
  nullable = true
  default  = null
}

variable "prefix" {
  type    = string
  default = ""
}
