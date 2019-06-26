terraform {
  backend "s3" {}
}

provider "pingdom" {}

resource "pingdom_check" "uat.claim-criminal-injuries-compensation.service.justice.gov.uk" {
  type                     = "http"
  name                     = "cicq - uat - cloud-platform - claim - health check"
  host                     = "uat.claim-criminal-injuries-compensation.service.justice.gov.uk"
  resolution               = 1
  notifywhenbackup         = true
  sendnotificationwhendown = 6
  notifyagainevery         = 0
  url                      = "/"
  encryption               = true
  port                     = 443
  tags                     = "businessunit_platforms,application_prometheus,component_healthcheck,isproduction_true,environment_uat,infrastructuresupport_platforms"
  probefilters             = "region:EU"
  publicreport             = "true"
}
