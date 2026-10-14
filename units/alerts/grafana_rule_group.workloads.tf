resource "grafana_rule_group" "workloads" {
  name             = "workloads"
  folder_uid       = grafana_folder.kubernetes.uid
  interval_seconds = 60

  rule {
    name           = "ContainerOOMKilled"
    condition      = "B"
    for            = "1m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Container {{ $labels.container }} in pod {{ $labels.pod }} (namespace {{ $labels.namespace }}) was OOMKilled"
      description = "{{ $value }} OOM event(s) were observed for container {{ $labels.container }} in pod {{ $labels.pod }} within the last 10 minutes."
    }

    labels = {
      severity = "warning"
    }

    data {
      ref_id         = "A"
      datasource_uid = var.prometheus_datasource_uid

      relative_time_range {
        from = 600
        to   = 0
      }

      model = jsonencode({
        datasource    = { type = "prometheus", uid = var.prometheus_datasource_uid }
        editorMode    = "code"
        expr          = "increase(container_oom_events_total{container!=\"\"}[10m]) > 0"
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
        from = 600
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
    name           = "KubePodCrashLooping"
    condition      = "B"
    for            = "5m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Pod {{ $labels.namespace }}/{{ $labels.pod }} is crash looping"
      description = "Container {{ $labels.container }} restarted more than 3 times in the last 15 minutes ({{ $value }} restarts)."
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
        expr          = "increase(kube_pod_container_status_restarts_total[15m]) > 3"
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
    name           = "KubePodNotReady"
    condition      = "B"
    for            = "15m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Pod {{ $labels.namespace }}/{{ $labels.pod }} has been not ready for more than 15 minutes"
      description = "Pod {{ $labels.namespace }}/{{ $labels.pod }} has been in a not-ready state for more than 15 minutes."
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
        expr          = "kube_pod_status_ready{condition=\"true\"} == 0 and on(namespace, pod) kube_pod_status_phase{phase=~\"Running|Pending\"} == 1"
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
    name           = "KubeDeploymentReplicasMismatch"
    condition      = "B"
    for            = "15m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "Deployment {{ $labels.namespace }}/{{ $labels.deployment }} has unavailable replicas"
      description = "Deployment {{ $labels.namespace }}/{{ $labels.deployment }} has {{ $value }} replicas that do not match its desired replica count."
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
        expr          = "kube_deployment_spec_replicas != kube_deployment_status_replicas_available"
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
    name           = "KubeStatefulSetReplicasMismatch"
    condition      = "B"
    for            = "15m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} has unavailable replicas"
      description = "StatefulSet {{ $labels.namespace }}/{{ $labels.statefulset }} has {{ $value }} ready replicas that do not match its desired replica count."
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
        expr          = "kube_statefulset_status_replicas_ready != kube_statefulset_status_replicas"
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
    name           = "KubePVCPending"
    condition      = "B"
    for            = "15m"
    no_data_state  = "OK"
    exec_err_state = "Error"

    annotations = {
      summary     = "PersistentVolumeClaim {{ $labels.namespace }}/{{ $labels.persistentvolumeclaim }} is {{ $labels.phase }}"
      description = "PersistentVolumeClaim {{ $labels.namespace }}/{{ $labels.persistentvolumeclaim }} has been in phase {{ $labels.phase }} for more than 15 minutes."
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
        expr          = "kube_persistentvolumeclaim_status_phase{phase!=\"Bound\"} == 1"
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
