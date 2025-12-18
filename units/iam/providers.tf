provider "restapi" {
  uri                  = var.pocket_id_url
  write_returns_object = true
  debug                = true
  headers = {
    "X-API-Key" = var.pocket_id_api_key
  }
}
