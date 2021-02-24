
variable "cluster_name" {
}

variable "cluster_state_bucket" {
}

variable "application" {
  description = "Name of Application you are deploying"
  default     = "Gov.UK Prototype Kit"
}

variable "namespace" {
  default = "opg-gt-test-prototype"
}

variable "business_unit" {
  description = "Area of the MOJ responsible for the service."
  default     = "OPG"
}

variable "team_name" {
  description = "The name of your development team"
  default     = "gt-test-team"
}

variable "environment" {
  description = "The type of environment you're deploying to."
  default     = "development"
}

variable "infrastructure_support" {
  description = "The team responsible for managing the infrastructure. Should be of the form team-email."
  default     = "platforms@digital.justice.gov.uk"
}

variable "is_production" {
  default = "false"
}

variable "slack_channel" {
  description = "Team slack channel to use if we need to contact your team"
  default     = "gt-test"
}

variable "github_owner" {
  description = "Required by the github terraform provider"
  default     = "ministryofjustice"
}

variable "github_token" {
  description = "Required by the github terraform provider"
  default     = ""
}

## Prototype kit variables

variable "basic-auth-username" {
  description = "Basic auth. username of the deployed prototype website"
  default     = "protouser"
}

variable "basic-auth-password" {
  description = "Basic auth. password of the deployed prototype website"
  default     = "protopass"
}
