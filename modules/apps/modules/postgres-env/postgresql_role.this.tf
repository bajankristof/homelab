resource "postgresql_role" "this" {
  name     = var.role_name
  login    = true
  password = random_password.this.result
}
