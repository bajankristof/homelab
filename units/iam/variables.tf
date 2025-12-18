variable "pocket_id_url" {
  type = string
}

variable "pocket_id_api_key" {
  type      = string
  sensitive = true
}

variable "iam_users" {
  type = list(object({
    username   = string
    email      = string
    first_name = string
    last_name  = string
    is_admin   = optional(bool, false)
  }))
}
