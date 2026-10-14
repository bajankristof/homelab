output "fqdn" {
  value = "${data.kubernetes_service_v1.this.metadata[0].name}.${kubernetes_namespace_v1.this.metadata[0].name}.svc.cluster.local"
}

output "port" {
  value = data.kubernetes_service_v1.this.spec[0].port[0].port
}

output "node_port" {
  value = data.kubernetes_service_v1.this.spec[0].port[0].node_port
}

output "root_user" {
  value = "postgres"
}

output "root_password" {
  value     = random_password.root.result
  sensitive = true
}
