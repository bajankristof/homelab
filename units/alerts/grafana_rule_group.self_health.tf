resource "grafana_rule_group" "self_health" {
  name             = "self-health"
  folder_uid       = grafana_folder.kubernetes.uid
  interval_seconds = 60

  rule {
    name           = "ScrapeTargetDown"
    condition      = "B"
    for            = "5m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Scrape target {{ $labels.job }} ({{ $labels.instance }}) is down"
      description = "The {{ $labels.job }} scrape target at {{ $labels.instance }} has been unreachable for more than 5 minutes."
    }

    labels = {
      severity = "critical"
    }

    data {
      ref_id         = "A"
      datasource_uid = var.prometheus_datasource_uid

      relative_time_range {
        from = 300
        to   = 0
      }

      model = jsonencode({
        datasource    = { type = "prometheus", uid = var.prometheus_datasource_uid }
        editorMode    = "code"
        expr          = "up == 0"
        instant       = true
        range         = false
        refId         = "A"
        intervalMs    = 1000
        maxDataPoints = 43200
      })
    }

    data {
      ref_id         = "B"
      datasource_uid = "-100"

      relative_time_range {
        from = 300
        to   = 0
      }

      model = jsonencode({
        conditions = [{
          evaluator = { params = [0], type = "gt" }
          operator  = { type = "and" }
          query     = { params = ["A"] }
          reducer   = { params = [], type = "last" }
          type      = "query"
        }]
        datasource = { type = "__expr__", uid = "-100" }
        refId      = "B"
        type       = "classic_conditions"
      })
    }
  }
}
