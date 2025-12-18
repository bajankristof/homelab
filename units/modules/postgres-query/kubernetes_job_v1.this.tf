resource "kubernetes_job_v1" "this" {
  wait_for_completion = true

  timeouts {
    create = "15m"
    delete = "5m"
    update = "5m"
  }

  metadata {
    name      = var.name
    namespace = var.namespace
  }

  spec {
    backoff_limit = 5
    ttl_seconds_after_finished = 300

    template {
      metadata {
        name = var.name
      }

      spec {
        restart_policy = "Never"

        container {
          name = "postgres"
          image = "postgres:18-alpine"
          command = ["psql"]
          args = [var.database_url, "-c", var.sql]
          #args = ["-f", "/sql/query.sql"]
        }
      }
    }
  }
}
