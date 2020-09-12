variable "name" {
  type        = string
  default     = "cloudsploit-scanner"
  description = "Name of Cloudsploit Scanner Installation"
}

variable "namespace" {
  type        = string
  description = "Company or Organization Prefix"
}

variable "stage" {
  type        = string
  default     = null
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "schedule" {
  type        = string
  default     = "0 3 * * 0"
  description = "Schedule to run Scans. Defaults to every 2 Hours between 6am and 6pm on Monday to Friday"
}

variable "scanner_version" {
  type        = string
  default     = "0.1.0"
  description = "Desired Scanner Docker Image Tag"
}

variable "k8s_namespace" {
  type        = string
  default     = "default"
  description = "Kubernetes Namespace to deploy CronJob and Config into"
}

variable "compliance_scans" {
  type        = list(string)
  default     = []
  description = "List of Compliance Scans to execute. See https://github.com/cloudsploit/scans#compliance"
}

variable "plugin_scan" {
  type        = string
  default     = ""
  description = "Plugin Scan to execute. See https://github.com/cloudsploit/scans/tree/master/plugins"
}

variable "scan_details_host" {
  type        = string
  default     = ""
  description = "Host used to build Link to a Detail View of executed Scans. Used for Notifications"
}

variable "scan_details_prefix" {
  type        = string
  default     = ""
  description = "URL Prefix used to build Link to a Detail View of executed Scans. Used for Notifications"
}

variable "discord_webhook_url" {
  type        = string
  default     = ""
  description = "Webhook URL to send Notification about new Reports to (/apis/webhooks/...). Enables Discord Notification"
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "Retention in Days for Reports to be available in S3"
}

variable "job_annotations" {
  type        = map(string)
  default     = {}
  description = "Additional Annotations for the Job Template"
}

variable "job_environment" {
  type        = map(string)
  default     = {}
  description = "Additional Environment Variables for the Job Template"
}
