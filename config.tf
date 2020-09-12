locals {
  discord_notification_config = var.discord_webhook_url == "" ? {} : {
    type = "discord"
    url  = var.discord_webhook_url
    scanDetails = {
      host   = var.scan_details_host
      prefix = var.scan_details_prefix
    }
  }

  s3_upload_config = var.cloudsploit_s3_bucket == "" ? {} : {
    type   = "s3"
    bucket = var.cloudsploit_s3_bucket
    client = {
      region = data.aws_region.current.name
    }
  }
}

resource "kubernetes_config_map" "scanner_config" {
  metadata {
    name      = var.name
    namespace = var.k8s_namespace
  }

  data = {
    "config.json" = jsonencode({
      upload       = merge({}, local.s3_upload_config)
      notification = merge({}, local.discord_notification_config)
    })
  }
}
