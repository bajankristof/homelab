module "postgres_query_pocket_id_setup" {
  source = "../modules/postgres-query"

  name         = "pocket-id-setup"
  database_url = module.postgres_env["pocket_id"].url
  sql          = <<EOF
INSERT INTO users (id, username, email, display_name, is_admin, created_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  'terraform',
  'terraform@${var.cloudflare_tld}',
  'Terraform',
  TRUE,
  NOW()
)
ON CONFLICT DO NOTHING;

INSERT INTO api_keys (id, name, key, user_id, created_at, expires_at)
VALUES (
  '00000000-0000-0000-0000-000000000000',
  'terraform',
  '${sha256(random_password.pocket_id_api_key.result)}',
  (SELECT id FROM users WHERE username='terraform'),
  NOW(),
  NOW() + INTERVAL '69 years'
)
ON CONFLICT DO NOTHING;
EOF
}

