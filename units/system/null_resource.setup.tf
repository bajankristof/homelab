resource "null_resource" "setup" {
  connection {
    type     = "ssh"
    host     = var.homelab_ip
    user     = var.homelab_username
    password = var.homelab_password
  }

  # === Install packages ===
  provisioner "remote-exec" {
    inline = [
      "sudo pacman -Syuq --noconfirm",
      "sudo pacman -Sq --noconfirm fd git neovim samba tailscale",
    ]
  }

  # === Setup Tailscale ===
  provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable --now tailscaled",
      "sudo tailscale up --auth-key ${var.tailscale_auth_key}",
    ]
  }

  # === Setup Samba ===
  provisioner "file" {
    content = templatefile("${path.module}/templates/smb.conf", {
      allowed_hosts = join(" ", [
        trimsuffix(local.network_cidr_block, "0/24"),
        "127.0.",
      ])
    })

    destination = "/tmp/smb.conf"
  }

  # === Setup Samba Share ===
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/smb.conf /etc/samba/smb.conf",
      "sudo mkdir -p /srv/samba/share",
      "sudo chown -R nobody:nobody /srv/samba",
      "sudo systemctl enable smb.service",
      "sudo systemctl start smb.service",
    ]
  }

  # === Add Samba User ===
  provisioner "remote-exec" {
    inline = [
      <<EOF
sudo smbpasswd -n -a ${var.homelab_username} <<EOS
${var.homelab_password}
${var.homelab_password}
EOS
EOF
    ]
  }

  # === Install k3s ===
  provisioner "remote-exec" {
    inline = [
      <<EOF
curl -sfL https://get.k3s.io | \
  sudo sh -s - \
    --write-kubeconfig-mode 644 \
    --disable-network-policy \
    --disable traefik,servicelb,metrics-server
EOF
      ,
      "sudo cp /etc/rancher/k3s/k3s.yaml kubeconfig",
      "sed -i 's/127.0.0.1/${var.homelab_ip}/g' kubeconfig",
      "nohup python -m http.server 6969 > /dev/null 2>&1 & disown",
      "sleep 1",
    ]
  }

  # === Download kubeconfig ===
  provisioner "local-exec" {
    command = "curl http://${var.homelab_ip}:6969/kubeconfig -o ${local.kubeconfig_path}"
  }

  # === Cleanup ===
  provisioner "remote-exec" {
    inline = [
      "sudo pkill -f 'python -m http.server 6969'",
    ]
  }
}
