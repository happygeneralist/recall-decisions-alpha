module "pathfinder_document_s3_bucket" {
  source                 = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.6"
  team_name              = var.team_name
  acl                    = "private"
  versioning             = true
  business-unit          = var.business-unit
  application            = var.application
  is-production          = var.is-production
  environment-name       = var.environment-name
  infrastructure-support = var.infrastructure-support
  namespace              = var.namespace

  providers = {
    aws = aws.london
  }

  user_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
  {
    "Sid": "",
    "Effect": "Allow",
    "Action": [
      "s3:GetBucketLocation",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads",
      "s3:GetLifecycleConfiguration",
      "s3:PutLifecycleConfiguration"
    ],
    "Resource": "$${bucket_arn}"
  },
  {
    "Sid": "",
    "Effect": "Allow",
    "Action": [
      "s3:GetObject",
      "s3:GetObjectVersionTagging",
      "s3:GetObjectTagging",
      "s3:GetObjectVersionAcl",
      "s3:GetObjectAcl",
      "s3:GetObjectVersion",
      "s3:GetObjectVersionTorrent",
      "s3:GetObjectTorrent",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:DeleteObjectVersionTagging",
      "s3:DeleteObjectTagging",
      "s3:RestoreObject",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectTagging",
      "s3:PutObjectVersionAcl",
      "s3:PutObjectAcl",
      "s3:PutObject"
    ],
    "Resource": "$${bucket_arn}/*"
  }
]
}
EOF

}

module "pathfinder_rds_to_s3_bucket" {
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

module "pathfinder_reporting_s3_bucket" {
  source = "github.com/ministryofjustice/cloud-platform-terraform-s3-bucket?ref=4.6"

  team_name              = var.team_name
  business-unit          = "Digital and Technology"
  application            = var.application
  infrastructure-support = var.infrastructure-support
  acl                    = "private"
  is-production          = var.is_production
  environment-name       = var.environment-name
  namespace              = var.namespace

  providers = {
    # Can be either "aws.london" or "aws.ireland"
    aws = aws.london
  }

  versioning = false
}

resource "kubernetes_secret" "pathfinder_document_s3_bucket" {
  metadata {
    name      = "pathfinder-document-s3-bucket-output"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.pathfinder_document_s3_bucket.access_key_id
    secret_access_key = module.pathfinder_document_s3_bucket.secret_access_key
    bucket_arn        = module.pathfinder_document_s3_bucket.bucket_arn
    bucket_name       = module.pathfinder_document_s3_bucket.bucket_name
  }
}

resource "kubernetes_secret" "pathfinder_rds_to_s3_bucket" {
  metadata {
    name      = "pathfinder-rds-to-s3-bucket-output"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.pathfinder_rds_to_s3_bucket.access_key_id
    secret_access_key = module.pathfinder_rds_to_s3_bucket.secret_access_key
    bucket_arn        = module.pathfinder_rds_to_s3_bucket.bucket_arn
    bucket_name       = module.pathfinder_rds_to_s3_bucket.bucket_name
  }
}

resource "kubernetes_secret" "pathfinder_reporting_s3_bucket" {
  metadata {
    name      = "pathfinder-reporting-s3-bucket"
    namespace = var.namespace
  }

  data = {
    access_key_id     = module.pathfinder_reporting_s3_bucket.access_key_id
    secret_access_key = module.pathfinder_reporting_s3_bucket.secret_access_key
    bucket_arn        = module.pathfinder_reporting_s3_bucket.bucket_arn
    bucket_name       = module.pathfinder_reporting_s3_bucket.bucket_name
  }
}