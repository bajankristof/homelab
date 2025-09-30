output "postgres_host" {
  value = data.kubernetes_service.postgres.metadata[0].name
}

output "postgres_port" {
  value = data.kubernetes_service.postgres.spec[0].port[0].port
}

output "postgres_node_port" {
  value = data.kubernetes_service.postgres.spec[0].port[0].node_port
}

output "postgres_root_user" {
  value = "postgres"
}

output "postgres_root_password" {
  value     = random_password.postgres.result
  sensitive = true
}
