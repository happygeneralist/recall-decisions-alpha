
variable "cluster_name" {
}


variable "application" {
  description = "Name of Application you are deploying"
  default     = "Legal Framework API"
}

variable "namespace" {
  default = "legal-framework-api-uat"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "LAA"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "laa-apply-for-legal-aid"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "uat"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "apply@digital.justice.gov.uk"
}

variable "is_production" {
  default = "true"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "applyprivatebeta"
}

variable "github_owner" {
  description = "Required by the github terraform provider"
  default     = "ministryofjustice"
}

variable "github_token" {
  description = "Required by the github terraform provider"
  default     = ""
}
