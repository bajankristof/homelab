resource "restapi_object" "user" {
  for_each = { for u in var.iam_users : u.username => u }

  path = "/api/users"
  data = jsonencode({
    username    = each.key
    email       = each.value.email
    firstName   = each.value.first_name
    lastName    = each.value.last_name
    displayName = "${each.value.first_name} ${each.value.last_name}"
    isAdmin     = each.value.is_admin
  })
}
