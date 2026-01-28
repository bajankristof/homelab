resource "random_password" "pocket_id_encryption_key" {
  length  = 32
  special = false
}
