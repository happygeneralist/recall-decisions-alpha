module "serviceaccount" {
  source              = "github.com/ministryofjustice/cloud-platform-terraform-serviceaccount?ref=0.5"
  namespace           = var.namespace
  github_repositories = ["hmpps-reference-data"]
}
