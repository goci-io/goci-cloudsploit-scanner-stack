locals {
  discord_notification_config = var.discord_webhook_url == "" ? {} : {
    type = "discord"
    url  = var.discord_webhook_url
    scanDetails = {
      host   = var.scan_details_host
      prefix = var.scan_details_prefix
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
      notification = merge({}, local.discord_notification_config)
      upload = {
        type   = "s3"
        bucket = module.s3_reports.this_s3_bucket_id
        client = {
          region = data.aws_region.current.name
        }
      }
    })
  }
}

module "bucket_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.16.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  attributes = var.attributes
  tags       = var.tags
}

module "s3_reports" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  bucket        = module.bucket_label.id
  tags          = module.bucket_label.tags
  acl           = "private"
  force_destroy = true
  lifecycle_rule = [
    {
      expiration = {
        days = var.retention_in_days
      }

      id = "CloudSploitClean"
      tags = merge(module.bucket_label.tags, {
        AutoClean = "true",
        Retention = format("%d Days", var.retention_in_days)
      })
    }
  ]
}
