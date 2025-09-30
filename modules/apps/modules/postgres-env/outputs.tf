output "database" {
  value = postgresql_database.this
}

output "role" {
  value = postgresql_role.this
}

output "auth" {
  value = "${urlencode(postgresql_role.this.name)}:${urlencode(random_password.this.result)}"
}
