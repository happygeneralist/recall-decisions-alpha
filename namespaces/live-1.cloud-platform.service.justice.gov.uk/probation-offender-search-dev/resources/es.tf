module "probation_offender_search_es" {
  source                        = "github.com/ministryofjustice/cloud-platform-terraform-elasticsearch?ref=3.5.1"
  cluster_name                  = var.cluster_name
  cluster_state_bucket          = var.cluster_state_bucket
  application                   = var.application
  business-unit                 = var.business-unit
  environment-name              = var.environment-name
  infrastructure-support        = var.infrastructure-support
  is-production                 = var.is-production
  team_name                     = var.team_name
  elasticsearch-domain          = "probation-search"
  namespace                     = var.namespace
  elasticsearch_version         = "7.9"
  aws-es-proxy-replica-count    = 2
  instance_type                 = "t2.medium.elasticsearch"
  s3_manual_snapshot_repository = module.es_snapshots_s3_bucket.bucket_arn
}

module "probation_offender_search_elasticsearch" {
  source                          = "github.com/ministryofjustice/cloud-platform-terraform-elasticsearch?ref=fix_up_aws_es_proxy_deployment"
  cluster_name                    = var.cluster_name
  cluster_state_bucket            = var.cluster_state_bucket
  application                     = var.application
  business-unit                   = var.business-unit
  environment-name                = var.environment-name
  infrastructure-support          = var.infrastructure-support
  is-production                   = var.is-production
  team_name                       = var.team_name
  elasticsearch-domain            = "search-probation"
  encryption_at_rest              = true
  node_to_node_encryption_enabled = true
  namespace                       = var.namespace
  elasticsearch_version           = "7.9"
  aws-es-proxy-replica-count      = 2
  instance_type                   = "t2.medium.elasticsearch"
  s3_manual_snapshot_repository   = module.es_snapshots_s3_bucket.bucket_arn
}

module "es_snapshots_s3_bucket" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.5"
  team_name              = var.team_name
  acl                    = "private"
  versioning             = false
  business-unit          = var.business-unit
  application            = var.application
  is-production          = var.is-production
  environment-name       = var.environment-name
  infrastructure-support = var.infrastructure-support
  namespace              = var.namespace

  providers = {
    aws = aws.london
  }
}

resource "kubernetes_secret" "es_snapshots_role" {
  metadata {
    name      = "es-snapshot-role"
    namespace = var.namespace
  }

  data = {
    snapshot_role_arn = module.probation_offender_search_es.snapshot_role_arn
  }
}

resource "kubernetes_secret" "es_snapshots" {
  metadata {
    name      = "es-snapshot-bucket"
    namespace = var.namespace
  }

  data = {
    bucket_arn  = module.es_snapshots_s3_bucket.bucket_arn
    bucket_name = module.es_snapshots_s3_bucket.bucket_name
  }
}

resource "kubernetes_secret" "elasticsearch" {
  metadata {
    name      = "elasticsearch"
    namespace = var.namespace
  }

  data = {
    aws_es_proxy_url = module.probation_offender_search_elasticsearch.aws_es_proxy_url
  }
}