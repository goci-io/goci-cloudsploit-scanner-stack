resource "kubernetes_config_map" "scanner_config" {
  metadata {
    name      = var.name
    namespace = var.k8s_namespace
  }

  data = {
    "config.json" = var.scanner_config
  }
}

resource "kubernetes_cron_job" "cloudsploit_scanner" {
  metadata {
    name      = var.name
    namespace = var.k8s_namespace
  }

  spec {
    failed_jobs_history_limit     = 3
    successful_jobs_history_limit = 1
    starting_deadline_seconds     = 300
    suspend                       = false
    schedule                      = var.schedule
    concurrency_policy            = "Replace"

    job_template {
      metadata {
        annotations = var.job_annotations
        labels = {
          app     = "cloudsploit-scanner"
          release = var.name
        }
      }

      spec {
        ttl_seconds_after_finished = 1800
        completions                = 1
        parallelism                = 1
        backoff_limit              = 3

        template {
          metadata {
            annotations = var.job_annotations
            labels = {
              app     = "cloudsploit-scanner"
              release = var.name
            }
          }

          spec {
            restart_policy = "OnFailure"

            volume {
              name = "config"

              config_map {
                name = kubernetes_config_map.scanner_config.metadata.0.name
              }
            }

            container {
              name  = "renovate"
              image = "gocidocker/cloudsploit-scanner:${var.scanner_version}"

              security_context {
                run_as_user                = 1000
                run_as_non_root            = true
                allow_privilege_escalation = false
              }

              resources {
                requests {
                  cpu    = "200m"
                  memory = "256Mi"
                }

                limits {
                  cpu    = "200m"
                  memory = "256Mi"
                }
              }

              env {
                name  = "CLOUDSPLOIT_CONFIG_PATH"
                value = "/usr/app/config.json"
              }

              dynamic "env" {
                for_each = var.job_environment

                content {
                  name  = env.key
                  value = env.value
                }
              }

              dynamic "env" {
                for_each = length(var.compliance_scans) > 0 ? [1] : []

                content {
                  name  = "CLOUDSPLOIT_COMPLIANCE"
                  value = join(",", var.compliance_scans)
                }
              }

              dynamic "env" {
                for_each = var.plugin_scan == "" ? [] : [1]

                content {
                  name  = "CLOUDSPLOIT_PLUGIN"
                  value = var.plugin_scan
                }
              }

              volume_mount {
                read_only  = true
                name       = "config"
                sub_path   = "config.json"
                mount_path = "/usr/app/config.json"
              }
            }
          }
        }
      }
    }
  }
}
