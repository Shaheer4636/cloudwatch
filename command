{
  "widgets": [
    { "type": "text", "x": 0, "y": 0, "width": 24, "height": 2,
      "properties": { "markdown": "# Amazon MQ for RabbitMQ — strata-uat-rabbitmq-mq-lmursoa (us-east-1)" } },

    /* ======== Overview (single values) ======== */
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

    /* ======== Backlog / Queue health ======== */
    { "type": "metric", "x": 0, "y": 8, "width": 12, "height": 6,
      "properties": { "title": "Queue length (all queues)", "region": "us-east-1", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "QueueLength", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 8, "width": 12, "height": 6,
      "properties": { "title": "Messages ready vs unacked", "region": "us-east-1", "view": "timeSeries",
        "metrics": [
          [ "AWS/AmazonMQ", "MessagesReady", "Broker", "strata-uat-rabbitmq-mq-lmursoa", { "id": "m1" } ],
          [ ".", "MessagesUnacknowledged", ".", "strata-uat-rabbitmq-mq-lmursoa", { "id": "m2" } ]
        ] } },

    /* ======== Traffic rates (msgs/sec) ======== */
    { "type": "metric", "x": 0, "y": 14, "width": 12, "height": 6,
      "properties": { "title": "Publish rate", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "PublishRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 14, "width": 12, "height": 6,
      "properties": { "title": "Deliver rate", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "DeliverRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 0, "y": 20, "width": 12, "height": 6,
      "properties": { "title": "Ack rate", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "AckRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 20, "width": 12, "height": 6,
      "properties": { "title": "Confirm rate", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "ConfirmRate", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },

    /* ======== Capacity indicators ======== */
    { "type": "metric", "x": 0, "y": 26, "width": 12, "height": 6,
      "properties": { "title": "Message bytes (total)", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "MessageBytes", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 26, "width": 12, "height": 6,
      "properties": { "title": "Message bytes in RAM vs persistent", "region": "us-east-1", "stat": "Average", "view": "timeSeries",
        "metrics": [
          [ "AWS/AmazonMQ", "MessageBytesRAM", "Broker", "strata-uat-rabbitmq-mq-lmursoa", { "id": "m1" } ],
          [ ".", "MessageBytesPersistent", ".", "strata-uat-rabbitmq-mq-lmursoa", { "id": "m2" } ]
        ] } },

    /* ======== Topline topology ======== */
    { "type": "metric", "x": 0, "y": 32, "width": 12, "height": 6,
      "properties": { "title": "Exchanges", "region": "us-east-1", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "ExchangeCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } },
    { "type": "metric", "x": 12, "y": 32, "width": 12, "height": 6,
      "properties": { "title": "Queues", "region": "us-east-1", "view": "timeSeries",
        "metrics": [ [ "AWS/AmazonMQ", "QueueCount", "Broker", "strata-uat-rabbitmq-mq-lmursoa" ] ] } }
  ],
  "start": "-PT3H",
  "periodOverride": "auto"
}



aws cloudwatch put-dashboard --dashboard-name AmazonMQ-RabbitMQ-uat --dashboard-body file://mqdashboard.json
