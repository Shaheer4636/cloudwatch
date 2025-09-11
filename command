cat > mqdashboard.json <<'JSON'
{
  "widgets": [
    { "type": "text", "x": 0, "y": 0, "width": 24, "height": 2,
      "properties": { "markdown": "# Amazon MQ for RabbitMQ — strata-uat-rabbitmq-mq-lmursoa (us-east-1)" } },

    { "type": "metric", "x": 0, "y": 2, "width": 6, "height": 6,
      "properties": { "title": "Connections", "view": "singleValue", "region": "us-east-1",
        "metrics": [ [ "AWS/AmazonMQ", "ConnectionCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 6, "y": 2, "width": 6, "height": 6,
      "properties": { "title": "Channels", "view": "singleValue", "region": "us-east-1",
        "metrics": [ [ "AWS/AmazonMQ", "ChannelCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 2, "width": 6, "height": 6,
      "properties": { "title": "Consumers", "view": "singleValue", "region": "us-east-1",
        "metrics": [ [ "AWS/AmazonMQ", "ConsumerCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 18, "y": 2, "width": 6, "height": 6,
      "properties": { "title": "Queues", "view": "singleValue", "region": "us-east-1",
        "metrics": [ [ "AWS/AmazonMQ", "QueueCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },

    { "type": "metric", "x": 0, "y": 8, "width": 12, "height": 6,
      "properties": { "title": "Queue length (all queues)", "region": "us-east-1", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "QueueLength", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 8, "width": 12, "height": 6,
      "properties": { "title": "Messages ready vs unacked", "region": "us-east-1", "view": "timeSeries",
        "metrics": [
          [ "AWS/AmazonMQ", "MessagesReady", "Broker", "strata-uat-rabbitmq-mq-lmursoa", { "id": "m1" } ],
          [ ".", "MessagesUnacknowledged", ".", "strata-uat-rabbitmq-mq-lmursoa", { "id": "m2" } ]
        ] } },

    { "type": "metric", "x": 0, "y": 14, "width": 12, "height": 6,
      "properties": { "title": "Publish rate (msgs/sec)", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "PublishRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 14, "width": 12, "height": 6,
      "properties": { "title": "Deliver rate (msgs/sec)", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "DeliverRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 0, "y": 20, "width": 12, "height": 6,
      "properties": { "title": "Ack rate (msgs/sec)", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "AckRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 20, "width": 12, "height": 6,
      "properties": { "title": "Confirm rate (msgs/sec)", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "ConfirmRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },

    { "type": "metric", "x": 0, "y": 26, "width": 12, "height": 6,
      "properties": { "title": "Exchange count", "region": "us-east-1", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "ExchangeCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 26, "width": 12, "height": 6,
      "properties": { "title": "Queue count", "region": "us-east-1", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "QueueCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } }
  ],
  "start": "-PT3H",
  "periodOverride": "auto"
}
JSON
