locals {
  prefix = var.prefix == "" ? "resources" : "${var.prefix}.resources"

  set = [
    for key, value in {
      "requests.cpu"    = var.cpu_request
      "requests.memory" = var.memory_request
      "limits.cpu"      = var.cpu_limit
      "limits.memory"   = var.memory_limit
      } : {
      name  = "${local.prefix}.${key}"
      value = value
    }
    if value != null
  ]
}

output "set" {
  value = local.set
}
