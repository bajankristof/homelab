provider "kubernetes" {
  config_path = var.kubeconfig_path
}

provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}

provider "postgresql" {
  host     = var.homelab_ip
  port     = var.postgres_node_port
  username = var.postgres_root_user
  password = var.postgres_root_password
  sslmode  = "disable"
}
