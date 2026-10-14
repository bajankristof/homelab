output "grafana_client_id" {
  value = restapi_object.grafana_app.id
}

output "grafana_client_secret" {
  value     = jsondecode(restapi_object.grafana_app.create_response)["createdSecret"]["secret"]
  sensitive = true
}
