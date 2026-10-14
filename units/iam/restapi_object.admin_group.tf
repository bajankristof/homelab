resource "restapi_object" "admin_group" {
  ignore_all_server_changes = true

  path = "/api/user-groups"
  data = jsonencode({
    name         = "admins"
    friendlyName = "Admins"
  })
}

resource "restapi_object" "admin_group_members" {
  ignore_all_server_changes = true

  path           = "/api/user-groups"
  create_method  = "PUT"
  create_path    = "/api/user-groups/${restapi_object.admin_group.id}/users"
  read_method    = "GET"
  read_path      = "/api/user-groups/{id}"
  update_method  = "PUT"
  update_path    = "/api/user-groups/{id}/users"
  destroy_method = "PUT"
  destroy_path   = "/api/user-groups/{id}/users"
  destroy_data   = jsonencode({ userIds = [] })

  data = jsonencode({
    userIds = [
      for u in var.iam_users : restapi_object.user[u.username].id if u.is_admin
    ]
  })
}
