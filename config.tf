resource "tls_private_key" "signing" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "kubernetes_secret" "signing_key" {
  metadata {
    name      = format("%s-key", var.name)
    namespace = var.k8s_namespace
  }

  data = {
    "signing.key" = tls_private_key.signing.private_key_pem
  }
}

resource "kubernetes_config_map" "scanner_config" {
  metadata {
    name      = var.name
    namespace = var.k8s_namespace
  }

  data = {
    "config.json" = jsonencode({
      upload = {
        type                 = "s3"
        cloudfrontUrlSigning = true
        cloudfrontKeypairId  = join("", module.cloudfront.cloudfront_keypair_ids)
        bucket               = module.cloudfront.bucket_id
        privateKeyPath       = "/usr/app/signing.key"
        client = {
          region = data.aws_region.current.name
        }
      }
    })
  }
}
