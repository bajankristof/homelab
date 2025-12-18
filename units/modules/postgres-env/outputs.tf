output "host" {
  value = var.host
}

output "port" {
  value = var.port
}

output "database" {
  value = postgresql_database.this
}

output "role" {
  value = postgresql_role.this
}

output "password" {
  value = random_password.this.result
  sensitive = true
}

output "url" {
  value = "postgresql://${urlencode(postgresql_role.this.name)}:${urlencode(random_password.this.result)}@${var.host}:${var.port}/${var.database_name}?sslmode=disable"
  sensitive = true
}
