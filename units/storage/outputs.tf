output "postgres_fqdn" {
  value = "${data.kubernetes_service_v1.postgres.metadata[0].name}.${kubernetes_namespace_v1.this.metadata[0].name}.svc.cluster.local"
}

output "postgres_port" {
  value = data.kubernetes_service_v1.postgres.spec[0].port[0].port
}

output "postgres_node_port" {
  value = data.kubernetes_service_v1.postgres.spec[0].port[0].node_port
}

output "postgres_root_user" {
  value = "postgres"
}

output "postgres_root_password" {
  value     = random_password.postgres.result
  sensitive = true
}
