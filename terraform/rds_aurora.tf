# Use your in-repo Aurora module folder; pipeline will check it out side-by-side.
module "rds_aurora_PostgreSQL" {
  source = "../RDS-Aurora-PostgreSQL-serverless"

  vpc_id                    = module.vpc.vpc_id
  database_subnets          = module.vpc.database_subnets
  region                    = var.region
  appname                   = var.appname
  env                       = var.env
  vpccidr                   = var.vpccidr
  tags                      = local.tags

  param_group_family        = "aurora-postgresql16"
  rds_aurora_engine_version = var.rds_aurora_postgresql_engine_version

  rds_aurora_enabled_cloudwatch_logs_exports = ["postgresql", "instance"]

  # Reuse the SG exported by the corporate SG module
  rds_aurora_vpc_security_group_ids = [
    module.security-groups.RDS_AuroraDB_SG_id
  ]

  # SNS topics for alarms/notifications
  critical_notification_sns = module.sns-subtopic.critical_notification_sns
  high_notification_sns     = module.sns-subtopic.high_notification_sns
  medium_notification_sns   = module.sns-subtopic.medium_notification_sns
}
