locals {
  base_url = var.base_url == null ? "https://${var.hostname}" : var.base_url
}

output "base_url" {
  value = local.base_url
}

output "api_key" {
  value     = random_password.pocket_id_api_key.result
  sensitive = true
}

output "auth_url" {
  value = "${local.base_url}/authorize"
}

output "token_url" {
  value = "${local.base_url}/api/oidc/token"
}

output "userinfo_url" {
  value = "${local.base_url}/api/oidc/userinfo"
}
