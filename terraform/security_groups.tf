# Corporate SG module (matches your later use of module.security-groups.RDS_AuroraDB_SG_id)
module "security-groups" {
  source = "../security-groups"

  vpc_id         = module.vpc.vpc_id
  name_prefix    = local.name
  tags           = local.tags

  # Common pattern: allow DB from private subnets + any corporate VPN ranges the module expects.
  # If this module expects a 'allowed_access' list, pass it like below:
  allowed_access = concat(local.private_subnets, local.database_subnets)

  # If your module needs an explicit flag to create an Aurora SG:
  # create_rds_auroradb_sg = true
}
