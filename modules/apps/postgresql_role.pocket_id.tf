resource "postgresql_role" "pocket_id" {
  name     = "pocket_id"
  login    = true
  password = random_password.postgres_pocket_id.result
}
