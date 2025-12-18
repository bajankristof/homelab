output "url" {
  value = "https://id.${var.cloudflare_tld}"
}

output "api_key" {
  value     = random_password.pocket_id_api_key.result
  sensitive = true
}
