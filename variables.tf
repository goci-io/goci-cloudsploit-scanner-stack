variable "name" {
  type        = string
  default     = "cloudsploit-scanner"
  description = "Name of Cloudsploit Scanner Installation"
}

variable "schedule" {
  type        = string
  default     = "0 3 * * 0"
  description = "Schedule to run Scans. Defaults to every 2 Hours between 6am and 6pm on Monday to Friday"
}

variable "scanner_version" {
  type        = string
  default     = "0.4.1"
  description = "Desired Scanner Docker Image Tag"
}

variable "scanner_config" {
  type        = string
  description = "Scanner Config in JSON Format. https://github.com/goci-io/cloudsploit-scanner/blob/master/config/example.json"
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
