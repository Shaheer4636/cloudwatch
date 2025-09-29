# General Variables
apprefidtag       = "d-server-01kmt1dl4o3snt"
install_dynatrace = "no"

# VPC
region         = "us-east-1"
appname        = "vmsnext"
env            = "idev"
eai            = "60912"
vpccidr        = "172.24.124.0/22"
privatesubnets = ["172.24.124.0/25", "172.24.124.128/25", "172.24.125.0/25"]
dbsubnets      = ["172.24.125.128/25", "172.24.126.0/25", "172.24.126.128/25"]
publicsubnets  = ["172.24.127.0/26", "172.24.127.64/26", "172.24.127.128/26"]
transitgwid    = "tgw-0da90b01c5f2c8024"
network_type   = "nonprod"

# RDS 
domain                                = "d-9067668e5e"
domain_iam_role_name                  = "rds-directoryservice-access-role"
initial_allocated_storage             = 200
max_allocated_storage                 = 500
license_model                         = "license-included"
engine                                = "sqlserver-se"
engine_version                        = "16.00.4095.4.v1"
major_engine_version                  = "16.00"
parameter_group_family                = "sqlserver-se-16.0"
storage_encrypted                     = true
db_instance_storage_type              = "gp3"
db_iops                               = "3000"
enabled_cloudwatch_logs_exports       = ["error", "agent"]
timezone                              = "UTC"
rds_instance_class                    = "db.r5.large"
dbrefidtag                            = "d-server-01kp6uoutysm46"
enable_multi_az                       = false
backup_retention_period               = 7
performance_insights_enabled          = false
monitoring_interval                   = 0
create_monitoring_role                = false
performance_insights_retention_period = 7
monitoring_role_name                  = "vmsnext-idev"
DatabaseConnections_threshold         = "1000"
kms_key_id                            = "arn:aws:kms:us-east-1:456310863931:key/016bde32-c09e-4d2c-824d-150d0450d7b9"
NetworkReceiveThroughput_High_threshold = 4000000

#EFS
throughput_mode = "elastic"

## EKS
cluster_endpoint_private_access = false
cluster_endpoint_public_access  = true
cluster_version                 = "1.32"
eks_root_volume_size            = 80
cert_domain_name                = "vmsnext-dev.situsamc.com"
pods_per_node_threshold         = 52
eks_listen_to_port              = 10027
eks_listen_from_port            = 10027
#eks_ec2_role                    = "vmsnext-idev-eks-ouHQTSdH2022030820025468550000001b"

instance_types = ["t3.2xlarge"]
desired_size   = 3
max_size       = 7
min_size       = 3
map_users      = []
map_roles = [
  {
    rolearn  = "arn:aws:iam::456310863931:role/AWSReservedSSO_AWSAdministratorAccess_2a5b473c54c3cb2e",
    username = "adminuser:{{SessionName}}",
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::456310863931:role/AWSReservedSSO_AWSReadOnlyAccess_b1d598208fda68b6",
    username = "readonlyuser:{{SessionName}}",
    groups   = ["view"]
  },
  {
    rolearn  = "arn:aws:iam::456310863931:role/AWSReservedSSO_Project_Devops_Dev_PowerUsers_fa3755d239027f3c",
    username = "poweruser:{{SessionName}}",
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::456310863931:role/AWSReservedSSO_AWS_EKS_Admin_SAMCDev_Users_ffe4ec50e6512e96",
    username = "adminuser:{{SessionName}}",
    groups   = ["system:masters"]
  },
  {
    rolearn  = "arn:aws:iam::456310863931:role/AWSReservedSSO_AWS_DevOps_SRE_7da23ce357dc3e18",
    username = "adminuser:{{SessionName}}",
    groups   = ["system:masters"]
  },
]

## MongoDB
mongo_instance_type       = "t3.medium"
mongo_data_volume_size    = 64
mongo_journal_volume_size = 32
mongo_log_volume_size     = 32



# Rabbit MQ
rmq_host_instance_type = "mq.m5.large"
rmq_engine_version     = "3.13"
rmq_deployment_mode    = "SINGLE_INSTANCE"
// rabbitmq_broker_name   = "vmsnext-idev-rabbitmq-mq-phzainv"
// queue_alarms = [
//   {
//     queue_name         = "domain-metadata-queue"
//     warning_threshold  = 20
//     alert_threshold    = 1000
//     critical_threshold = 2000
//     evaluation_period  = 2
//     warning_sns_topic_arns  = ["arn:aws:sns:us-east-1:456310863931:vmsnext-idev-monitoring-medium"]
//     alert_sns_topic_arns    = ["arn:aws:sns:us-east-1:456310863931:vmsnext-idev-monitoring-High"]
//     critical_sns_topic_arns = ["arn:aws:sns:us-east-1:456310863931:vmsnext-idev-monitoring-CRITICAL"]
//   },
//   {
//     queue_name         = "valuation-task-queue"
//     warning_threshold  = 20
//     alert_threshold    = 1000
//     critical_threshold = 2500
//     evaluation_period  = 2
//     warning_sns_topic_arns  = ["arn:aws:sns:us-east-1:456310863931:vmsnext-idev-monitoring-medium"]
//     alert_sns_topic_arns    = ["arn:aws:sns:us-east-1:456310863931:vmsnext-idev-monitoring-Hight"]
//     critical_sns_topic_arns = ["arn:aws:sns:us-east-1:456310863931:vmsnext-idev-monitoring-CRITICAL"]
//   }
// ]

// queue_depth_alarm_period = 300  # 5 minutes

# Cidr_blocks for communicating with Rabbit MQ
allowed_cidr_blocks = ["172.22.128.0/22", "172.18.0.0/16", "172.22.8.0/23", "172.22.248.0/22"]

## NLB
eks_internal_port = 31139
eks_external_port = 30579

## ElastiCache
elasticache_cluster_size         = 2
elasticache_instance_type        = "cache.t2.medium"
redis_engine_version             = "7.0"
redis_family                     = "redis7"
transit_encryption_enabled       = false
cloudwatch_metric_alarms_enabled = true
create_elasticache_SG            = true

#SNS
email_list = ["cresreteam@situsamc.com","vmsnext-devnotify@situsamc.com","f40d432e.situsamc.com@amer.teams.ms"]
email_list_high = ["cresreteam@situsamc.com","vmsnext-devnotify@situsamc.com","f40d432e.situsamc.com@amer.teams.ms"]
email_list_medium = ["cresreteam@situsamc.com","vmsnext-devnotify@situsamc.com","f40d432e.situsamc.com@amer.teams.ms"]
pagerDuty_ep = ""
pagerDuty_ep_high = ""
pagerDuty_ep_medium = ""
