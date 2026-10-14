# homelab

This repository contains configuration files and documentation for my personal homelab setup.

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform)
- [Terragrunt](https://terragrunt.gruntwork.io/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/)
- A [Tailscale](https://tailscale.com/) account and an auth key.
- Local network subnet with a `/24` mask.
- Reserved IP addresses from `.201` to `.254` for MetalLB IP allocation.
- An Arch Linux server on your local network with SSH access.
  - The SSH user must have passwordless `sudo` access (see below).
  - The SSH user's password must NOT contain single or double quotes.
- A [Cloudflare](https://www.cloudflare.com/) account with a domain name.
  - You need to create a Cloudflare API token with the following permissions:
    - Zone:DNS:Edit
    - Zone:Zone:Read
- A [Resend](https://resend.com/) account with a verified sending domain, used
  by Grafana to deliver alert notifications by email.

### sudoers

You need to add your user to the sudoers file to allow passwordless sudo access.
This is required for remote provisioners within Terraform. You can do this by
creating a file in `/etc/sudoers.d/` with the following content:

```
bajanland ALL=(ALL) NOPASSWD: ALL
```

```sh
sudo tee /etc/sudoers.d/bajanland <<EOF
bajanland ALL=(ALL) NOPASSWD: ALL
EOF
```

### backend.hcl

The remote Terraform state backend is configured in `backend.hcl` (gitignored).
Here is an example of what the file should look like:

```hcl
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "your-terraform-state"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
```

### env.tfvars

All environment-specific values live in a single, gitignored `env.tfvars` file
that `root.hcl` reads. Copy `env.tfvars.example` and fill it in:

```hcl
# Homelab access
homelab_ip         = "192.168.69.69" # optional, defaults to 192.168.69.69
homelab_username   = "hackerman"
homelab_password   = "secure!!!444four"
tailscale_auth_key = "tskey-auth-xxxxxxxxxxxx"

# DNS and TLS
cloudflare_tld           = "example.com"
cloudflare_dns_api_token = "abcdef1234567890"

# SMTP (used by Grafana to deliver alert notifications)
smtp_host     = "smtp.resend.com"
smtp_port     = 465
smtp_username = "resend"
smtp_password = "re_1234567890abcdef"

# IAM users
iam_users = [
  {
    username   = "john.doe"
    email      = "john.doe@example.com"
    first_name = "John"
    last_name  = "Doe"
    is_admin   = true
  },
]
```

Hosts and base URLs (`id.<tld>`, `grafana.<tld>`, `plex.<tld>`, …) are derived
from `cloudflare_tld` in `root.hcl`, so they're defined once and injected into
every unit.

The ACME (Let's Encrypt) contact and alert notification addresses are derived
from `cloudflare_tld` too: `acme@<tld>` and `alerts@<tld>`. Set up email
routing on your domain so that mail sent to those addresses reaches a mailbox
you actually read — Cloudflare Email Routing is a good option.


## Getting Started

Once you have all the requirements, you can simply run:

```sh
make apply
```

This _should_ set up the homelab from scratch.

## Architecture

![Architecture Diagram](https://raw.githubusercontent.com/bajankristof/homelab/main/arch.svg)
