REGION="us-east-1"; \
BROKER_NAME="strata-uat-rabbitmq-mq-1mursoa"; \
DB_INSTANCE_ID="mysql-strata-uat-master"; \
CANARY_NAME="strata-file-download"; \
DASH_NAME="AmazonMQ (strata-uat)"; \
DB_RESOURCE_ID="$(aws rds describe-db-instances --region "$REGION" --db-instance-identifier "$DB_INSTANCE_ID" --query 'DBInstances[0].DbiResourceId' --output text)"; \
cat > /tmp/cw-dashboard.json <<JSON
{
  "widgets": [
    { "type": "metric", "x": 0, "y": 0, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1",
        "title": "RabbitMQ Ack & Confirm rate",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ "AWS/AmazonMQ", "AckRate", "Broker", "strata-uat-rabbitmq-mq-1mursoa" ],
          [ ".", "ConfirmRate", ".", "." ]
        ],
        "yAxis": { "left": { "label": "msgs/sec" } }
      }
    },
    { "type": "metric", "x": 12, "y": 0, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Publish rate",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa} MetricName=\"PublishRate\"', 'Sum', 60)", "label": "PublishRate", "id": "e_pub" } ]
        ],
        "yAxis": { "left": { "label": "msgs/sec" } }
      }
    },
    { "type": "metric", "x": 0, "y": 6, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Queue size per queue (messages)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Queue,*} MetricName=\"QueueSize\"', 'Sum', 60)", "label": "QueueSize by queue", "id": "e_qsize" } ]
        ]
      }
    },
    { "type": "metric", "x": 12, "y": 6, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Total messages sent (enqueue)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Queue,*} MetricName=\"EnqueueCount\"', 'Sum', 60)", "label": "Enqueue by queue", "id": "e_enq_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Topic,*} MetricName=\"EnqueueCount\"', 'Sum', 60)", "label": "Enqueue by topic", "id": "e_enq_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 12, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Total messages received (dequeue)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Queue,*} MetricName=\"DequeueCount\"', 'Sum', 60)", "label": "Dequeue by queue", "id": "e_deq_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Topic,*} MetricName=\"DequeueCount\"', 'Sum', 60)", "label": "Dequeue by topic", "id": "e_deq_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 12, "y": 12, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Total messages sent to consumers (dispatch)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Queue,*} MetricName=\"DispatchCount\"', 'Sum', 60)", "label": "Dispatch by queue", "id": "e_disp_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Topic,*} MetricName=\"DispatchCount\"', 'Sum', 60)", "label": "Dispatch by topic", "id": "e_disp_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 18, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Consumers / Producers per destination",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Queue,*} MetricName=\"ConsumerCount\"', 'Average', 60)", "label": "Consumers (queue)", "id": "e_cc_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Queue,*} MetricName=\"ProducerCount\"', 'Average', 60)", "label": "Producers (queue)", "id": "e_pc_q" } ]
        ]
      }
    },
    { "type": "metric", "x": 12, "y": 18, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Total consumers per broker",
        "view": "singleValue", "stat": "Sum", "period": 60, "setPeriodToTimeRange": false,
        "metrics": [ [ "AWS/AmazonMQ", "TotalConsumerCount", "Broker", "strata-uat-rabbitmq-mq-1mursoa" ] ]
      }
    },
    { "type": "metric", "x": 0, "y": 24, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "CPU, Heap, Memory & Store usage (broker)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ "AWS/AmazonMQ", "CPUUtilization", "Broker", "strata-uat-rabbitmq-mq-1mursoa" ],
          [ ".", "HeapUsage", ".", "." ],
          [ ".", "MemoryUsage", ".", "." ],
          [ ".", "StorePercentUsage", ".", "." ]
        ],
        "yAxis": { "left": { "min": 0, "max": 100, "label": "%" } }
      }
    },
    { "type": "metric", "x": 12, "y": 24, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Network in/out (bytes)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ "AWS/AmazonMQ", "NetworkIn", "Broker", "strata-uat-rabbitmq-mq-1mursoa" ],
          [ ".", "NetworkOut", ".", "." ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 30, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "Broker message latency per destination (ms)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Queue,*} MetricName=\"EnqueueTime\"', 'Average', 60)", "label": "EnqueueTime (queue)", "id": "e_et_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,strata-uat-rabbitmq-mq-1mursoa,Topic,*} MetricName=\"EnqueueTime\"', 'Average', 60)", "label": "EnqueueTime (topic)", "id": "e_et_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 36, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "strata.file.download (Canary Success %)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "yAxis": { "left": { "min": 0, "max": 100, "label": "%" } },
        "metrics": [ [ "CloudWatchSynthetics", "SuccessPercent", "CanaryName", "strata-file-download" ] ]
      }
    },
    { "type": "metric", "x": 12, "y": 36, "width": 12, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "MySQL DB load (AAS) via Performance Insights",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ { "expression": "DB_PERF_INSIGHTS('RDS','$DB_RESOURCE_ID','db.load.avg')", "label": "DBLoad (AAS)", "id": "pi1" } ]
        ]
      }
    },
    { "type": "log", "x": 0, "y": 42, "width": 24, "height": 6,
      "properties": {
        "region": "us-east-1", "title": "MySQL Slow queries & avg Query_time (Logs Insights)",
        "query": "SOURCE '/aws/rds/instance/mysql-strata-uat-master/slowquery'\\n| filter @message like /Query_time/\\n| parse @message \"# Query_time: * Lock_time: * Rows_sent: * Rows_examined: *\" as query_time, lock_time, rows_sent, rows_examined\\n| stats count() as slow_queries, avg(query_time) as avg_qtime by bin(1m)",
        "stacked": false, "view": "timeSeries"
      }
    }
  ]
}
JSON
