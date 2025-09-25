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

### sudoers

You need to add your user to the sudoers file to allow passwordless sudo access.
This is required for remote provisioners within Terraform. You can do this by
creating a file in `/etc/sudoers.d/` with the following content:

```
hackerman ALL=(ALL) NOPASSWD: ALL
```

```sh
sudo tee /etc/sudoers.d/hackerman <<EOF
hackerman ALL=(ALL) NOPASSWD: ALL
EOF
```

### secrets.hcl

You need to create a `secrets.hcl` file in the root of the repository.
Here is an example of what the file should look like:

```hcl
inputs = {
  homelab_address = "192.168.69.69" # optional
  homelab_username = "hackerman"
  homelab_password = "secure!!!444four"
  tailscale_auth_key = "tskey-1234567890abcdef"
  acme_email = "john.doe@example.com"
  cloudflare_tld = "example.com"
  cloudflare_dns_api_token = "abcdef1234567890"
}
```

## Getting Started

Once you have all the requirements, you can simply run:

```sh
make apply
```

This _should_ set up the homelab from scratch.
