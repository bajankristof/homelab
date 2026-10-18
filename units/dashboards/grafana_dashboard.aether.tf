locals {
  prometheus_datasource = {
    type = "prometheus"
    uid  = var.prometheus_datasource_uid
  }
}

resource "grafana_dashboard" "aether" {
  folder = grafana_folder.aether.uid

  config_json = jsonencode({
    title         = "Aether"
    tags          = ["aether"]
    timezone      = "browser"
    schemaVersion = 39
    version       = 1
    refresh       = "1m"
    time          = { from = "now-6h", to = "now" }

    panels = [
      {
        type       = "timeseries"
        title      = "Torrent peers by state"
        gridPos    = { h = 9, w = 24, x = 0, y = 0 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum by (state) (aether.torrent.peers)"
            legendFormat = "{{state}}"
          }
        ]
        fieldConfig = {
          defaults = {
            unit = "short"
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
              stacking    = { mode = "normal", group = "A" }
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Torrent throughput"
        gridPos    = { h = 9, w = 12, x = 0, y = 9 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum by (direction) (rate(aether.torrent.bytes[5m]))"
            legendFormat = "{{direction}}"
          }
        ]
        fieldConfig = {
          defaults = {
            unit = "Bps"
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Read stalls (per hour)"
        gridPos    = { h = 9, w = 12, x = 12, y = 9 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum(increase(aether.torrent.read.stalls[1h]))"
            legendFormat = "stalls"
          }
        ]
        fieldConfig = {
          defaults = {
            unit     = "short"
            decimals = 0
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Torrent opens and releases"
        gridPos    = { h = 9, w = 12, x = 0, y = 18 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum(rate(aether.torrent.opens[10m]))"
            legendFormat = "opens"
          },
          {
            datasource   = local.prometheus_datasource
            refId        = "B"
            expr         = "sum(rate(aether.torrent.releases[10m]))"
            legendFormat = "releases"
          }
        ]
        fieldConfig = {
          defaults = {
            unit = "short"
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Tracker searches by result"
        gridPos    = { h = 9, w = 12, x = 12, y = 18 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum by (result) (increase(aether.tracker.searches[1h]))"
            legendFormat = "{{result}}"
          }
        ]
        fieldConfig = {
          defaults = {
            unit     = "short"
            decimals = 0
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Tracker downloads by result"
        gridPos    = { h = 9, w = 12, x = 0, y = 27 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum by (result) (increase(aether.tracker.downloads[1h]))"
            legendFormat = "{{result}}"
          }
        ]
        fieldConfig = {
          defaults = {
            unit     = "short"
            decimals = 0
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "TMDB requests by action"
        gridPos    = { h = 9, w = 12, x = 12, y = 27 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum by (action) (increase(aether.tmdb.requests[1h]))"
            legendFormat = "{{action}}"
          }
        ]
        fieldConfig = {
          defaults = {
            unit     = "short"
            decimals = 0
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Plex requests by action"
        gridPos    = { h = 9, w = 12, x = 0, y = 36 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum by (action) (increase(aether.plex.requests[1h]))"
            legendFormat = "{{action}}"
          }
        ]
        fieldConfig = {
          defaults = {
            unit     = "short"
            decimals = 0
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Indexed releases by kind"
        gridPos    = { h = 9, w = 12, x = 12, y = 36 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum by (kind, result) (increase(aether.index.releases[1h]))"
            legendFormat = "{{kind}} ({{result}})"
          }
        ]
        fieldConfig = {
          defaults = {
            unit     = "short"
            decimals = 0
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      },
      {
        type       = "timeseries"
        title      = "Pruned releases (per hour)"
        gridPos    = { h = 9, w = 12, x = 0, y = 45 }
        datasource = local.prometheus_datasource
        targets = [
          {
            datasource   = local.prometheus_datasource
            refId        = "A"
            expr         = "sum(increase(aether.releases.prunes[1h]))"
            legendFormat = "pruned"
          }
        ]
        fieldConfig = {
          defaults = {
            unit     = "short"
            decimals = 0
            custom = {
              fillOpacity = 10
              lineWidth   = 2
              showPoints  = "never"
            }
          }
          overrides = []
        }
        options = {
          legend  = { displayMode = "list", placement = "bottom", showLegend = true }
          tooltip = { mode = "multi", sort = "desc" }
        }
      }
    ]
  })
}
