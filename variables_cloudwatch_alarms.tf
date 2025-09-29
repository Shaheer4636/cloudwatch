# Amazon MQ Terraform Module
This module will create a Broker in the Amazon MQ service in the specified vpc.  The Broker can have the either an Apache ActiveMQ ('engine_type = ActiveMQ' ) or a RabbitMQ ('engine_type = RabbitMQ' ) broker engine.

# Prerequisites
A VPC should be created using the [DEVOPS_Platform_as_a_Service/vpc](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/vpc?version=GBmain) module.

# Getting Started

## Create Local AmazonMQ File
To create an Amazon MQ broker instances with this module, create a Terraform file like the following **example** in your pipeline Terraform code:
```
module "rabbitmq" {
  source                     = "../amazonmq"
  vpc_id                     = module.vpc.vpc_id
  situs_vpn_access           = module.vpc.allowed_access
  vpccidr                    = var.vpccidr
  appname                    = var.appname
  env                        = var.env
  region                     = var.region
  subnet_ids                 = module.vpc.private_subnets
  allowed_security_groups    = var.allowed_security_groups
  apply_immediately          = var.apply_immediately
  engine_type                = "RabbitMQ"
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  deployment_mode            = var.deployment_mode
  engine_version             = var.engine_version
  host_instance_type         = var.host_instance_type
  general_log_enabled        = var.general_log_enabled
  audit_log_enabled          = var.audit_log_enabled
  tags                       = local.tags
  critical_notification_sns  = module.sns-subtopic.critical_notification_sns
  high_notification_sns      = module.sns-subtopic.high_notification_sns
  medium_notification_sns    = module.sns-subtopic.medium_notification_sns
}
```
With the **example** above, it is likely best to name your file `rabbitmq.tf` to correspond with the local `module` **name** given and also with the `engine_type` used.  The `engine_type` can be either `ActiveMQ` or `RabbitMQ`.

If you want to override the default name of the Amazon MQ broker created by this module, then add the following four options to the above 
Terraform file you have:
```
  override_amq_name            = true
  samc_APP_CLIENT              = var.samc_APP_CLIENT
  samc_APP_NAME                = var.samc_APP_NAME
  samc_APP_ENV                 = var.samc_APP_ENV
```
The above override allows you to create brokers named like: `<samc:APP_CLIENT>-<samc:APP_NAME>-<samc:APP_ENV>-rabbitmq`

##  Configure your pipeline: Make sure your pipeline contains a reference to this source like this:
```
resources:
  repositories:
    - repository: amazonmq
      type: git
      name: amazonmq
      ref: refs/tags/2.5.1

stages:
- ${{ if eq(parameters.dev, true) }}:
  - template: deploy/tf-create-infra-template.yml@templates
    parameters:
      reqAmazonMQMod: true
```
## RabbitMQ Queue Depth Alarms

This module supports configurable CloudWatch alarms for RabbitMQ queue depth.  
You can declare the following variables in your application to enable per-queue alarms with custom thresholds and notification topics.

**Environment-Specific Overrides:**
To override the default queue depth alarm period for a specific environment (such as idev), set the `queue_depth_alarm_period` variable in your environment's `.tfvars` file. For example, in `vars/idev.tfvars`:

```hcl
queue_depth_alarm_period = 300  # 5 minutes
```

This ensures the override is applied for all runs using that environment's configuration.

### Example Variable Declaration

```hcl
variable "queue_alarms" {
  description = "List of queue alarm configurations for RabbitMQ depth"
  type = list(object({
    queue_name               = string
    warning_threshold        = number
    alert_threshold          = number
    critical_threshold       = number
    evaluation_period        = number
    warning_sns_topic_arns   = list(string)
    alert_sns_topic_arns     = list(string)
    critical_sns_topic_arns  = list(string)
  }))
  validation {
    condition = alltrue([
      for q in var.queue_alarms :
      length(q.queue_name) > 0 &&
      q.warning_threshold > 0 &&
      q.alert_threshold > q.warning_threshold &&
      q.critical_threshold > q.alert_threshold &&
      q.evaluation_period > 0 &&
      length(q.warning_sns_topic_arns) > 0 &&
      length(q.alert_sns_topic_arns) > 0 &&
      length(q.critical_sns_topic_arns) > 0
    ])
    error_message = "Invalid queue alarm settings. Ensure thresholds, names, and SNS topic lists are valid."
  }
}
```
variable "rabbitmq_broker_name" {
  description = "Name of the AmazonMQ RabbitMQ broker"
  type        = string
}
```

### Configuring the Queue Depth Alarm Period

By default, the period for RabbitMQ queue depth CloudWatch alarms is set to 900 seconds (15 minutes). You can override this by setting the `queue_depth_alarm_period` variable in your configuration:

```hcl
variable "queue_depth_alarm_period" {
  description = "The period (in seconds) over which the specified statistic is applied for RabbitMQ queue depth alarms."
  type        = number
  default     = 900
}

# Example override in your .tfvars or module block:
queue_depth_alarm_period = 300  # 5 minutes
```

Set this variable to control how frequently CloudWatch evaluates the queue depth metric for alarms.

### Example Usage

```hcl
queue_alarms = [
  {
    queue_name              = "orders"
    warning_threshold       = 1000
    alert_threshold         = 2000
    critical_threshold      = 5000
    evaluation_period       = 2
    warning_sns_topic_arns  = ["arn:aws:sns:us-east-1:123456789012:orders-warning"]
    alert_sns_topic_arns    = ["arn:aws:sns:us-east-1:123456789012:orders-alert"]
    critical_sns_topic_arns = ["arn:aws:sns:us-east-1:123456789012:orders-critical"]
  },
  {
    queue_name              = "payments"
    warning_threshold       = 500
    alert_threshold         = 1000
    critical_threshold      = 2500
    evaluation_period       = 2
    warning_sns_topic_arns  = ["arn:aws:sns:us-east-1:123456789012:payments-warning"]
    alert_sns_topic_arns    = ["arn:aws:sns:us-east-1:123456789012:payments-alert"]
    critical_sns_topic_arns = ["arn:aws:sns:us-east-1:123456789012:payments-critical"]
  }
]
```
rabbitmq_broker_name = "my-rabbitmq-broker"
```

**You can now specify different SNS topics for each alert level (warning, alert, critical) per queue. Add these variables to your application’s Terraform configuration to enable queue depth alarms for RabbitMQ.**

## Secrets Automatically Created in Secrets Manager
When using [deploy-templates](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/deploy-templates?version=GBmain) version 3.1.0 or newer, 
two secrets needed by this module are automatically created: `admin` and `appuser`.
As shown above, the `reqAmazonMQMod` flag **must** be set to `true` for the secrets to be created.
The name of the `admin` secret will be in the following form - with the `samc:appid` tag's value ("PMEMB") in lowercase letters - and 'engine_type' in lowercase letters:
```
/<samc:appid>/<samc:env>/engine_type/admin
```
For example:
```
/pmemb/dev/activemq/admin
```
Here is an **example** of what the key/value pairs will look like in your secret:
```
{
  "username": "admin",
  "password": "j4LU3bg8XvTcen8pJnAozhaGEF9FNh7h7"
}
```
**IMPORTANT NOTE:** For **RabbitMQ**, only the `appuser` credentials are used.

# Subject Matter Expert (SME)
The designated **SME** for this Amazon MQ module is Ashok Mourya (ashokmourya@situsamc.com)

# New In Version 2.6.1
- Fixed tagging so that `local.tags` are applied to all resources created (fixes [BUG 251285](https://samcado.visualstudio.com/DevOps/_workitems/edit/251285))
- Narrowed the security group's access to port 5671 - in cloudposse's [`sg.tf`](cloudposse_1.0.0_mq_broker/sg.tf) file.
- Copied [cloudposse's terraform-aws-mq-broker version 1.0.0 source](https://github.com/cloudposse/terraform-aws-mq-broker/tree/1.0.0) to the local [`cloudposse_1.0.0_mq_broker` folder](cloudposse_1.0.0_mq_broker) in this repository
- Added support for the `CLUSTER_MULTI_AZ` deployment mode for RabbitMQ.
- Added the `samc:DPAAS-module` and `samc:DPAAS-module-version` tags.
- Removed `samc:client` tag and corresponding optional `client` input.
- Added `local.tags` to CloudWatch alarm resources.

# New In Version 2.8.0
- Removed **unused** optional inputs: `SNSTopicCriticalArn` and `SNSTopicHighArn`
- Utilizes new optional inputs `high_notification_sns` and `critical_notification_sns` for setting SNS Topic Name to associate
with **High (Alert)** and **CRITICAL (SEVERE)** CloudWatch alarms, respectively. These allow alternatives to the previous SNS Topic
Name defaults: `"SHI_Monitoring_Notifications_High"` and `"SHI_Monitoring_Notifications_Critical"`.

# New In Version 2.9.0
- For RabbitMQ general logs are enabled by default.

# New In Version 2.9.1
- Fixed RabbitMQ alarms that were always in an insufficient data state when deployed in `CLUSTER_MULTI_AZ` mode.

# New In Version 3.0.0
- Moved `samc:DPAAS-module-version` tag to `cloudposse_1.0.0_mq_broker/main.tf`.
- Added **dependency** on new alarm status aggregator to summarize the status of all CloudWatch alarms into a single CloudWatch (CW) 
metric named "ActiveAlarms".  For more details, see the 
[alarm-aggregator module](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/alarm-aggregator?version=GBmain).
- Updated to include **dependency** on the 
[iam-controls](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/iam-controls?version=GBmain) module.

## Requires Updating Checkout Template and Pipeline YAML Files
The **dependency** on the **new** `alarm-aggregator` module will require updating your `-pipeline.yml` files to add something like this:
```
    - repository: alarm-aggregator
      type: git
      name: DEVOPS_Platform_as_a_Service/alarm-aggregator
      ref: refs/tags/1.0.0
    - repository: iam-controls
      type: git
      name: DEVOPS_Platform_as_a_Service/iam-controls
      ref: refs/tags/2.0.0
```
This will also require adding a new `checkout` to your checkout template YAML file like this:
```
- checkout: alarm-aggregator
  displayName: Get Alarm Aggregator module - ######

- checkout: iam-controls
  displayName: Get IAM Controls module - ######
```
Where `######` is a unique **random** six character id generated from here:
https://www.random.org/strings/?num=10&len=6&digits=on&upperalpha=on&loweralpha=on&unique=on&format=html&rnd=new

# New In Version 4.0.0
- Requires the setting of three notification SNS topics for alarm levels: critical, high & medium
- Enabled setting of `medium_notification_sns`: the notification SNS topic for medium (warning) level alarms.

# New In Version 4.1.0
- Added medium CloudWatch alerts for RabbitMQ:
    - Free disk space (medium)   = 30%
    - Memory utilization(medium) = 70%
    - CPU utilization(medium)    = 70%

# New In Version 4.2.0
- Added CloudWatch alarms and dashboard for ActiveMQ.
