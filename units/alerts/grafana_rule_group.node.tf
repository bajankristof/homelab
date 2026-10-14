resource "grafana_rule_group" "node" {
  name             = "node"
  folder_uid       = grafana_folder.kubernetes.uid
  interval_seconds = 60

  rule {
    name           = "KubeNodeNotReady"
    condition      = "B"
    for            = "5m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Node {{ $labels.node }} is not ready"
      description = "Node {{ $labels.node }} has reported a not-ready status for more than 5 minutes."
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
        expr          = "kube_node_status_condition{condition=\"Ready\",status=\"true\"} == 0"
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

  rule {
    name           = "KubeNodeDiskPressure"
    condition      = "B"
    for            = "5m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Node {{ $labels.node }} is under disk pressure"
      description = "Node {{ $labels.node }} has reported disk pressure for more than 5 minutes."
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
        expr          = "kube_node_status_condition{condition=\"DiskPressure\",status=\"true\"} == 1"
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

  rule {
    name           = "NodeFilesystemFilling"
    condition      = "B"
    for            = "15m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Filesystem {{ $labels.device }} on {{ $labels.instance }} is filling up"
      description = "Filesystem {{ $labels.device }} on {{ $labels.instance }} has less than 15% free space."
    }

    labels = {
      severity = "critical"
    }

    data {
      ref_id         = "A"
      datasource_uid = var.prometheus_datasource_uid

      relative_time_range {
        from = 900
        to   = 0
      }

      model = jsonencode({
        datasource    = { type = "prometheus", uid = var.prometheus_datasource_uid }
        editorMode    = "code"
        expr          = "min by (instance, device) (node_filesystem_avail_bytes{fstype!~\"tmpfs|ramfs|overlay|squashfs\"} / node_filesystem_size_bytes{fstype!~\"tmpfs|ramfs|overlay|squashfs\"}) < 0.15"
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
        from = 900
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

  rule {
    name           = "NodeMemoryPressure"
    condition      = "B"
    for            = "15m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Node {{ $labels.instance }} is low on memory"
      description = "Node {{ $labels.instance }} has less than 10% of its memory available."
    }

    labels = {
      severity = "warning"
    }

    data {
      ref_id         = "A"
      datasource_uid = var.prometheus_datasource_uid

      relative_time_range {
        from = 900
        to   = 0
      }

      model = jsonencode({
        datasource    = { type = "prometheus", uid = var.prometheus_datasource_uid }
        editorMode    = "code"
        expr          = "node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes < 0.1"
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
        from = 900
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
