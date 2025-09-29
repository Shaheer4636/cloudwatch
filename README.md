# Amazon MQ Terraform Module

This module creates an Amazon MQ **Broker** in a specified VPC.  
Supported engines: **Apache ActiveMQ** (`engine_type = "ActiveMQ"`) and **RabbitMQ** (`engine_type = "RabbitMQ"`).

---

## Prerequisites

A VPC must be created using the [DEVOPS_Platform_as_a_Service/vpc](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/vpc?version=GBmain) module.

---

## Getting Started

### Create Local Amazon MQ File

To create a broker with this module, add a Terraform file such as:

```hcl
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
  engine_type                = "RabbitMQ" # or "ActiveMQ"
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  deployment_mode            = var.deployment_mode
  engine_version             = var.engine_version
  host_instance_type         = var.host_instance_type
  general_log_enabled        = var.general_log_enabled
  audit_log_enabled          = var.audit_log_enabled

  critical_notification_sns  = module.sns_subtopic.critical_notification_sns
  high_notification_sns      = module.sns_subtopic.high_notification_sns
  medium_notification_sns    = module.sns_subtopic.medium_notification_sns

  tags = local.tags
}
```

> **Tip:** Save this file as `rabbitmq.tf` to match the module name and `engine_type`.

---

### Override Broker Name

Optionally, override the default broker name by adding:

```hcl
override_amq_name = true
samc_APP_CLIENT   = var.samc_APP_CLIENT
samc_APP_NAME     = var.samc_APP_NAME
samc_APP_ENV      = var.samc_APP_ENV
```

This produces broker names such as:

```
<samc:APP_CLIENT>-<samc:APP_NAME>-<samc:APP_ENV>-rabbitmq
```

---

### Pipeline Reference

```yaml
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

---

## RabbitMQ Queue Depth Alarms

This module supports **CloudWatch alarms** for RabbitMQ queue depth with thresholds and per-level SNS topics.

### Environment-Specific Override

Override the global alarm evaluation period in `.tfvars`:

```hcl
# vars/idev.tfvars
queue_depth_alarm_period = 300  # 5 minutes
```

Default is **900 seconds** (15 minutes).

---

### Variables

```hcl
# Optional broker name
variable "rabbitmq_broker_name" {
  description = "Name of the AmazonMQ RabbitMQ broker. Leave null if not using RabbitMQ."
  type        = string
  default     = null

  validation {
    condition     = var.rabbitmq_broker_name == null || length(trim(var.rabbitmq_broker_name)) > 0
    error_message = "If provided, rabbitmq_broker_name must be a non-empty string."
  }
}

# Optional queue alarm list
variable "queue_alarms" {
  description = "Optional list of per-queue alarm configurations for RabbitMQ depth."
  type = list(object({
    queue_name              = string
    virtual_host            = string
    warning_threshold       = number
    alert_threshold         = number
    critical_threshold      = number
    evaluation_period       = optional(number, 300)
    warning_sns_topic_arns  = optional(list(string), [])
    alert_sns_topic_arns    = optional(list(string), [])
    critical_sns_topic_arns = optional(list(string), [])
  }))
  default = []

  validation {
    condition = alltrue([
      for q in var.queue_alarms :
      length(trim(q.queue_name)) > 0 &&
      length(trim(q.virtual_host)) > 0 &&
      q.warning_threshold > 0 &&
      q.alert_threshold    > q.warning_threshold &&
      q.critical_threshold > q.alert_threshold &&
      q.evaluation_period  > 0
    ])
    error_message = "Invalid queue alarm settings: non-empty names, ascending thresholds, evaluation_period > 0."
  }
}

# Global queue depth alarm period
variable "queue_depth_alarm_period" {
  description = "Period (seconds) for evaluating RabbitMQ queue depth alarms."
  type        = number
  default     = 900
}
```

---

### Example Usage

```hcl
queue_alarms = [
  {
    queue_name              = "orders"
    virtual_host            = "/"
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
    virtual_host            = "/"
    warning_threshold       = 500
    alert_threshold         = 1000
    critical_threshold      = 2500
    evaluation_period       = 2
    warning_sns_topic_arns  = ["arn:aws:sns:us-east-1:123456789012:payments-warning"]
    alert_sns_topic_arns    = ["arn:aws:sns:us-east-1:123456789012:payments-alert"]
    critical_sns_topic_arns = ["arn:aws:sns:us-east-1:123456789012:payments-critical"]
  }
]

rabbitmq_broker_name = "my-rabbitmq-broker"
```

---

## Secrets Automatically Created in Secrets Manager

When using [deploy-templates](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/deploy-templates?version=GBmain) `v3.1.0+`, two secrets are automatically created:

* `admin`
* `appuser`

The `reqAmazonMQMod` flag **must** be set to `true` for the secrets to be provisioned.

**Secret name format:**

```
/<samc:appid>/<samc:env>/engine_type/admin
```

For example:

```
/pmemb/dev/activemq/admin
```

**Example secret contents:**

```json
{
  "username": "admin",
  "password": "j4LU3bg8XvTcen8pJnAozhaGEF9FNh7h7"
}
```

> **Note:** For **RabbitMQ**, only the `appuser` credentials are used.

---

## Subject Matter Expert (SME)

* Ashok Mourya – [ashokmourya@situsamc.com](mailto:ashokmourya@situsamc.com)

---

## Version History (Highlights)

* **2.6.1**: Fixed tagging (`local.tags`), limited security group access, copied CloudPosse `mq-broker` v1.0.0.
* **2.8.0**: Removed unused SNS inputs, added `high_notification_sns` & `critical_notification_sns`.
* **2.9.0**: RabbitMQ general logs enabled by default.
* **2.9.1**: Fixed alarms stuck in insufficient data state under `CLUSTER_MULTI_AZ`.
* **3.0.0**: Added dependency on [alarm-aggregator](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/alarm-aggregator?version=GBmain) and [iam-controls](https://samcado.visualstudio.com/DEVOPS_Platform_as_a_Service/_git/iam-controls?version=GBmain).
* **4.0.0**: Requires all three notification SNS topics (critical, high, medium).
* **4.1.0**: Added medium RabbitMQ alarms (disk, memory, CPU).
* **4.2.0**: Added ActiveMQ CloudWatch alarms and dashboards.
