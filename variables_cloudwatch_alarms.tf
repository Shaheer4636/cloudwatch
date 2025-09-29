variable "NodeName" {
  default = "rabbit@localhost"
}

variable "medium_notification_sns" {
  description = "Required value for specifying AWS SNS topic Name for medium (warning) CloudWatch alarms."
  type        = string
}

variable "high_notification_sns" {
  description = "Required value for specifying AWS SNS topic Name for High (Alert) CloudWatch alarms"
  type        = string
}

variable "critical_notification_sns" {
  description = "Required value for specifying AWS SNS topic Name for CRITICAL (SEVERE) CloudWatch alarms"
  type        = string
}

variable "queue_alarms" {
  description = "List of queue alarm configurations for RabbitMQ depth"
  type = list(object({
    queue_name               = string
    virtual_host             = string
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
      length(q.virtualhost) > 0 &&
      q.warning_threshold > 0 &&
      q.alert_threshold > q.warning_threshold &&
      q.critical_threshold > q.alert_threshold &&
      q.evaluation_period > 0 &&
      length(q.warning_sns_topic_arns) > 0 &&
      length(q.alert_sns_topic_arns) > 0 &&
      length(q.critical_sns_topic_arns) > 0
    ])
    error_message = "Invalid queue alarm settings. Ensure thresholds, names and SNS topic lists are valid."
  }
}

variable "queue_depth_alarm_period" {
  description = "The period (in seconds) over which the specified statistic is applied for RabbitMQ queue depth alarms."
  type        = number
  default     = 900
  validation {
    condition     = var.queue_depth_alarm_period >= 60 && var.queue_depth_alarm_period % 60 == 0
    error_message = "The period must be a multiple of 60 seconds and at least 60."
  }
}

variable "rabbitmq_broker_name" {
  description = "Name of the AmazonMQ RabbitMQ broker"
  type        = string
}
