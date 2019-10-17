################################################################################
# Use of force Application Elasticache for ReDiS
################################################################################

module "uof_elasticache_redis" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-elasticache-cluster?ref=3.1"
  cluster_name           = "${var.cluster_name}"
  cluster_state_bucket   = "${var.cluster_state_bucket}"
  application            = "${var.application}"
  environment-name       = "${var.environment-name}"
  is-production          = "${var.is-production}"
  infrastructure-support = "${var.infrastructure-support}"
  team_name              = "${var.team_name}"
  number_cache_clusters  = "${var.number_cache_clusters}"
  node_type              = "cache.t2.small"
}

resource "kubernetes_secret" "uof_elasticache_redis" {
  metadata {
    name      = "uof-elasticache-redis"
    namespace = "${var.namespace}"
  }

  data {
    primary_endpoint_address = "${module.uof_elasticache_redis.primary_endpoint_address}"
    auth_token               = "${module.uof_elasticache_redis.auth_token}"
    member_clusters          = "${jsonencode(module.uof_elasticache_redis.member_clusters)}"
  }
}
