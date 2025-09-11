{
  "widgets": [
    { "type": "text", "x": 0, "y": 0, "width": 24, "height": 2,
      "properties": { "markdown": "# Amazon MQ RabbitMQ: strata-uat-rabbitmq-mq-lmursoa" } },

    { "type": "metric", "x": 0, "y": 2, "width": 12, "height": 6,
      "properties": {
        "title": "Publish rate (msgs/sec)",
        "region": "us-east-1",
        "stat": "Average",
        "view": "timeSeries",
        "metrics": [
          [ "AWS/AmazonMQ", "PublishRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ]
        ]
      }
    },

    { "type": "metric", "x": 12, "y": 2, "width": 12, "height": 6,
      "properties": {
        "title": "Ack rate (msgs/sec)",
        "region": "us-east-1",
        "stat": "Average",
        "view": "timeSeries",
        "metrics": [
          [ "AWS/AmazonMQ", "AckRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ]
        ]
      }
    },

    { "type": "metric", "x": 0, "y": 8, "width": 12, "height": 6,
      "properties": {
        "title": "Queue length",
        "region": "us-east-1",
        "stat": "Average",
        "view": "timeSeries",
        "metrics": [
          [ "AWS/AmazonMQ", "QueueLength", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ]
        ]
      }
    },

    { "type": "metric", "x": 12, "y": 8, "width": 12, "height": 6,
      "properties": {
        "title": "Consumer count",
        "region": "us-east-1",
        "stat": "Average",
        "view": "timeSeries",
        "metrics": [
          [ "AWS/AmazonMQ", "ConsumerCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ]
        ]
      }
    }
  ],
  "start": "-PT3H",
  "periodOverride": "auto"
}






aws cloudwatch put-dashboard \
  --dashboard-name AmazonMQ-RabbitMQ-uat \
  --dashboard-body file://mqdashboard.json
