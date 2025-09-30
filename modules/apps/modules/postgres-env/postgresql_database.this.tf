resource "postgresql_database" "this" {
  name  = var.database_name
  owner = postgresql_role.this.name
}
