locals {
  charts_path           = "${path.module}/../../charts"
  postgres_url_template = "postgres://$${auth}@$${host}:$${port}/$${database}?sslmode=disable"
}
