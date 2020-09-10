variable "name" {
  type        = string
  default     = "cloudsploit-scanner"
  description = "Name of Cloudsploit Scanner Installation"
}

variable "namespace" {
  type        = string
  default     = ""
  description = "Company or Organization Prefix"
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

variable "jobs_url" {
  type        = string
  default     = ""
  description = "URL used to link to a Detail View of executed Scans"
}

variable "discord_webhook_url" {
  type        = string
  default     = ""
  description = "Webhook URL to send Notification about new Reports to (/apis/webhooks/...). Enables Discord Notification"
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
