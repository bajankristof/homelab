locals {
  tfvars = jsondecode(read_tfvars_file("${get_repo_root()}/env.tfvars"))

  # Homelab access
  homelab_ip         = try(local.tfvars.homelab_ip, "192.168.69.69")
  homelab_username   = local.tfvars.homelab_username
  homelab_password   = local.tfvars.homelab_password
  tailscale_auth_key = local.tfvars.tailscale_auth_key

  # DNS and TLS
  cloudflare_tld           = local.tfvars.cloudflare_tld
  cloudflare_dns_api_token = local.tfvars.cloudflare_dns_api_token
  acme_email               = "acme@${local.cloudflare_tld}"

  # Hostnames and URLs
  pocket_id_hostname = "id.${local.cloudflare_tld}"
  pocket_id_base_url = "https://${local.pocket_id_hostname}"
  plex_hostname      = "plex.${local.cloudflare_tld}"
  plex_base_url      = "https://${local.plex_hostname}"
  seerr_hostname     = "seerr.${local.cloudflare_tld}"
  seerr_base_url     = "https://${local.seerr_hostname}"
  grafana_hostname   = "grafana.${local.cloudflare_tld}"
  grafana_base_url   = "https://${local.grafana_hostname}"
  traefik_hostname   = "traefik.${local.cloudflare_tld}"
  traefik_base_url   = "https://${local.traefik_hostname}"

  # SMTP
  smtp_host     = local.tfvars.smtp_host
  smtp_port     = local.tfvars.smtp_port
  smtp_username = local.tfvars.smtp_username
  smtp_password = local.tfvars.smtp_password

  # Alert notifications
  alert_email = "alerts@${local.cloudflare_tld}"

  # IAM
  iam_users = try(local.tfvars.iam_users, [])
}

inputs = {
  # Kubernetes
  kubeconfig_path = "${get_repo_root()}/kubeconfig"

  # Helm charts
  charts_path = "${get_repo_root()}/charts"
}
