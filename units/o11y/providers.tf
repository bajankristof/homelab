provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}

provider "restapi" {
  uri                  = var.pocket_id_base_url
  write_returns_object = true
  headers = {
    "X-API-Key" = var.pocket_id_api_key
  }
}
