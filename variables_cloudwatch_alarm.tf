variable "NodeName" {
  type    = string
  default = "rabbit@localhost"
}

variable "medium_notification_sns" {
  description = "Required value for specifying AWS SNS topic Name for medium (warning) CloudWatch alarms."
  type        = string
  validation {
    condition     = length(trim(var.medium_notification_sns)) > 0
    error_message = "medium_notification_sns cannot be empty."
  }
}

variable "high_notification_sns" {
  description = "Required value for specifying AWS SNS topic Name for High (Alert) CloudWatch alarms."
  type        = string
  validation {
    condition     = length(trim(var.high_notification_sns)) > 0
    error_message = "high_notification_sns cannot be empty."
  }
}

variable "critical_notification_sns" {
  description = "Required value for specifying AWS SNS topic Name for CRITICAL (SEVERE) CloudWatch alarms."
  type        = string
  validation {
    condition     = length(trim(var.critical_notification_sns)) > 0
    error_message = "critical_notification_sns cannot be empty."
  }
}

variable "queue_alarms" {
  description = "Optional list of queue alarm configs for RabbitMQ depth. Empty list = no alarms."
  type = list(object({
    queue_name              = string
    virtual_host            = string
    warning_threshold       = number
    alert_threshold         = number
    critical_threshold      = number
    # Optional fields with safe defaults:
    evaluation_period       = optional(number, 300)
    warning_sns_topic_arns  = optional(list(string), [])
    alert_sns_topic_arns    = optional(list(string), [])
    critical_sns_topic_arns = optional(list(string), [])
  }))
  # Make the entire input optional at the call site.
  default = []

  validation {
    condition = alltrue([
      for q in var.queue_alarms :
      length(trim(q.queue_name)) > 0 &&
      length(trim(q.virtual_host)) > 0 &&
      q.warning_threshold > 0 &&
      q.alert_threshold > q.warning_threshold &&
      q.critical_threshold > q.alert_threshold &&
      q.evaluation_period > 0
    ])
    error_message = "Invalid queue alarm settings. Names must be non-empty; thresholds must be ascending and > 0; evaluation_period > 0."
  }
}

variable "queue_depth_alarm_period" {
  description = "The period (in seconds) over which the specified statistic is applied for RabbitMQ queue depth alarms."
  type        = number
  default     = 300
  validation {
    condition     = var.queue_depth_alarm_period >= 60 && var.queue_depth_alarm_period % 60 == 0
    error_message = "The period must be a multiple of 60 seconds and at least 60."
  }
}

variable "rabbitmq_broker_name" {
  description = "Name of the AmazonMQ RabbitMQ broker (optional)."
  type        = string
  default     = null
  validation {
    condition     = var.rabbitmq_broker_name == null || length(trim(var.rabbitmq_broker_name)) > 0
    error_message = "rabbitmq_broker_name cannot be empty when provided."
  }
}
