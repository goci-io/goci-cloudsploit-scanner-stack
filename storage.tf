module "cloudfront" {
  source    = "git::https://github.com/goci-io/aws-cloudfront-s3.git?ref=master"
  namespace = var.namespace
  name               = var.name
  cloudfront_comment = "Cloudsploit Scan Results via Signed URLs"
  cloudfront_min_ttl = 0
  cloudfront_max_ttl = 0
  cloudfront_default_ttl = 0
  cloudfront_viewer_protocol_policy = "https-only"
  cloudfront_public_keys = [tls_private_key.signing.public_key_pem]
  lifecycle_expiration_rules = {
    cleanup = {
      prefix           = "/"
      expirationInDays = 14
    }
  }

  providers = {
    aws = aws
    aws.us-east = aws.us-east
  }
}
