################################################################################
# Track a Query (Correspondence Tool Staff)
# Application RDS (PostgreSQL)
#################################################################################

module "dex_mi_production_rds" {
  source                     = "github.com/ministryofjustice/cloud-platform-terraform-rds-instance?ref=5.16.5"
  cluster_name               = var.cluster_name
  team_name                  = "correspondence"
  business-unit              = "Central Digital"
  application                = "dex-mi-metabase"
  is-production              = var.is-production
  namespace                  = var.namespace
  db_engine                  = "postgres"
  db_engine_version          = "12"
  db_backup_retention_period = "7"
  db_name                    = "metabase_production"
  environment-name           = var.environment-name
  infrastructure-support     = "correspondence-support@digital.justice.gov.uk"

  rds_family = "postgres12"

  # use "allow_major_version_upgrade" when upgrading the major version of an engine
  allow_major_version_upgrade = "false"

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "dex_mi_production_rds" {
  metadata {
    name      = "dex-mi-production-rds-output"
    namespace = var.namespace
  }

  data = {
    rds_instance_endpoint = module.dex_mi_production_rds.rds_instance_endpoint
    database_name         = module.dex_mi_production_rds.database_name
    database_username     = module.dex_mi_production_rds.database_username
    database_password     = module.dex_mi_production_rds.database_password
    rds_instance_address  = module.dex_mi_production_rds.rds_instance_address

    access_key_id     = module.dex_mi_production_rds.access_key_id
    secret_access_key = module.dex_mi_production_rds.secret_access_key

    url = "postgres://${module.dex_mi_production_rds.database_username}:${module.dex_mi_production_rds.database_password}@${module.dex_mi_production_rds.rds_instance_endpoint}/${module.dex_mi_production_rds.database_name}"
  }
}

