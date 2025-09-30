resource "postgresql_database" "pocket_id" {
  name  = "pocket_id"
  owner = postgresql_role.pocket_id.name
}
