module "postgres_env" {
  for_each = toset(["pocket_id"])

  source = "./modules/postgres-env"

  database_name = each.value
  role_name     = each.value
}
