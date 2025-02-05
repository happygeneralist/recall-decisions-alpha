module "education_skills_work_employment_storage_bucket" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.6"
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

module "education_skills_work_employment_rds_to_s3_bucket" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.6"
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

resource "kubernetes_secret" "education_skills_work_employment_storage_bucket" {
  metadata {
    name      = "education-skills-work-employment-storage-bucket-output"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.education_skills_work_employment_storage_bucket.access_key_id
    secret_access_key = module.education_skills_work_employment_storage_bucket.secret_access_key
    bucket_arn        = module.education_skills_work_employment_storage_bucket.bucket_arn
    bucket_name       = module.education_skills_work_employment_storage_bucket.bucket_name
  }
}

resource "kubernetes_secret" "education_skills_work_employment_rds_to_s3_bucket" {
  metadata {
    name      = "education-skills-work-employment-rds-to-s3-bucket-output"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.education_skills_work_employment_rds_to_s3_bucket.access_key_id
    secret_access_key = module.education_skills_work_employment_rds_to_s3_bucket.secret_access_key
    bucket_arn        = module.education_skills_work_employment_rds_to_s3_bucket.bucket_arn
    bucket_name       = module.education_skills_work_employment_rds_to_s3_bucket.bucket_name
  }
}
