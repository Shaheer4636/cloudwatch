output "vpc_id" {
  value = module.vpc.vpc_id
}

output "db_cluster_arn" {
  value = try(module.rds_aurora_PostgreSQL.db_cluster_arn, null)
}

output "db_endpoint" {
  value = try(module.rds_aurora_PostgreSQL.reader_endpoint, null)
}
