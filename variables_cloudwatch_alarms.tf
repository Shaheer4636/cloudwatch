variable "queue_alarms" {
  description = "Optional list of queue alarm configs for RabbitMQ depth. Empty list = no alarms."
  type = list(object({
    queue_name              = string
    virtual_host            = string
    warning_threshold       = number
    alert_threshold         = number
    critical_threshold      = number
    # Make these optional with defaults:
    evaluation_period       = optional(number, 300)
    warning_sns_topic_arns  = optional(list(string), [])
    alert_sns_topic_arns    = optional(list(string), [])
    critical_sns_topic_arns = optional(list(string), [])
  }))

  # Makes the whole input optional at the module callsite
  default = []

  validation {
    condition = alltrue([
      for q in var.queue_alarms :
      length(trim(q.queue_name)) > 0 &&
      length(trim(q.virtual_host)) > 0 &&      # fixed key: was 'virtualhost'
      q.warning_threshold > 0 &&
      q.alert_threshold > q.warning_threshold &&
      q.critical_threshold > q.alert_threshold &&
      q.evaluation_period > 0
    ])
    error_message = "Invalid queue alarm settings. Names must be non-empty; thresholds must be ascending and > 0; evaluation_period > 0."
  }
}
