variable "rabbitmq_broker_name" {
  description = "Name of the AmazonMQ RabbitMQ broker (optional)"
  type        = string
  default     = null

  # If the caller sets it, it must be non-empty.
  validation {
    condition     = var.rabbitmq_broker_name == null || length(trim(var.rabbitmq_broker_name)) > 0
    error_message = "rabbitmq_broker_name cannot be empty when provided."
  }
}
