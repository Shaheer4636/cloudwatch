REGION="${AWS_REGION:-$(aws configure get region || echo us-east-1)}"; BROKER_NAME="BROKER_NAME"; CANARY_NAME="strata-file-download"; DB_RESOURCE_ID="DB_RESOURCE_ID"; DB_INSTANCE_ID="DB_INSTANCE_ID"; DASH_NAME="AmazonMQ (strata-idev)"; \
TMP="/tmp/cw-dashboard.json"; \
cat >"$TMP" <<'__CW_JSON__'
{
  "widgets": [
    { "type": "metric", "x": 0, "y": 0, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}",
        "title": "RabbitMQ Ack & Confirm rate",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ "AWS/AmazonMQ", "AckRate", "Broker", "${BROKER_NAME}" ],
          [ ".", "ConfirmRate", ".", "." ]
        ],
        "yAxis": { "left": { "label": "msgs/sec" } }
      }
    },
    { "type": "metric", "x": 12, "y": 0, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Publish rate",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME}} MetricName=\"PublishRate\"', 'Sum', 60)", "label": "PublishRate", "id": "e_pub" } ]
        ],
        "yAxis": { "left": { "label": "msgs/sec" } }
      }
    },
    { "type": "metric", "x": 0, "y": 6, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Queue size per queue (messages)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Queue,*} MetricName=\"QueueSize\"', 'Sum', 60)", "label": "QueueSize by queue", "id": "e_qsize" } ]
        ]
      }
    },
    { "type": "metric", "x": 12, "y": 6, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Total messages sent (enqueue)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Queue,*} MetricName=\"EnqueueCount\"', 'Sum', 60)", "label": "Enqueue by queue", "id": "e_enq_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Topic,*} MetricName=\"EnqueueCount\"', 'Sum', 60)", "label": "Enqueue by topic", "id": "e_enq_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 12, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Total messages received (dequeue)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Queue,*} MetricName=\"DequeueCount\"', 'Sum', 60)", "label": "Dequeue by queue", "id": "e_deq_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Topic,*} MetricName=\"DequeueCount\"', 'Sum', 60)", "label": "Dequeue by topic", "id": "e_deq_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 12, "y": 12, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Total messages sent to consumers (dispatch)",
        "view": "timeSeries", "stat": "Sum", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Queue,*} MetricName=\"DispatchCount\"', 'Sum', 60)", "label": "Dispatch by queue", "id": "e_disp_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Topic,*} MetricName=\"DispatchCount\"', 'Sum', 60)", "label": "Dispatch by topic", "id": "e_disp_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 18, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Consumers / Producers per destination",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Queue,*} MetricName=\"ConsumerCount\"', 'Average', 60)", "label": "Consumers (queue)", "id": "e_cc_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Queue,*} MetricName=\"ProducerCount\"', 'Average', 60)", "label": "Producers (queue)", "id": "e_pc_q" } ]
        ]
      }
    },
    { "type": "metric", "x": 12, "y": 18, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Total consumers per broker",
        "view": "singleValue", "stat": "Sum", "period": 60, "setPeriodToTimeRange": false,
        "metrics": [ [ "AWS/AmazonMQ", "TotalConsumerCount", "Broker", "${BROKER_NAME}" ] ]
      }
    },
    { "type": "metric", "x": 0, "y": 24, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "CPU, Heap, Memory & Store usage (broker)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ "AWS/AmazonMQ", "CPUUtilization", "Broker", "${BROKER_NAME}" ],
          [ ".", "HeapUsage", ".", "." ],
          [ ".", "MemoryUsage", ".", "." ],
          [ ".", "StorePercentUsage", ".", "." ]
        ],
        "yAxis": { "left": { "min": 0, "max": 100, "label": "%" } }
      }
    },
    { "type": "metric", "x": 12, "y": 24, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Network in/out (bytes)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ "AWS/AmazonMQ", "NetworkIn", "Broker", "${BROKER_NAME}" ],
          [ ".", "NetworkOut", ".", "." ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 30, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "Broker message latency per destination (ms)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Queue,*} MetricName=\"EnqueueTime\"', 'Average', 60)", "label": "EnqueueTime (queue)", "id": "e_et_q" } ],
          [ { "expression": "SEARCH('{AWS/AmazonMQ,Broker,${BROKER_NAME},Topic,*} MetricName=\"EnqueueTime\"', 'Average', 60)", "label": "EnqueueTime (topic)", "id": "e_et_t" } ]
        ]
      }
    },
    { "type": "metric", "x": 0, "y": 36, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "strata.file.download (Canary Success %)",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "yAxis": { "left": { "min": 0, "max": 100, "label": "%" } },
        "metrics": [ [ "CloudWatchSynthetics", "SuccessPercent", "CanaryName", "${CANARY_NAME}" ] ]
      }
    },
    { "type": "metric", "x": 12, "y": 36, "width": 12, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "MySQL DB load (AAS) via Performance Insights",
        "view": "timeSeries", "stat": "Average", "period": 60,
        "metrics": [
          [ { "expression": "DB_PERF_INSIGHTS('RDS','${DB_RESOURCE_ID}','db.load.avg')", "label": "DBLoad (AAS)", "id": "pi1" } ]
        ]
      }
    },
    { "type": "log", "x": 0, "y": 42, "width": 24, "height": 6,
      "properties": {
        "region": "${REGION}", "title": "MySQL Slow queries & avg Query_time (Logs Insights)",
        "query": "SOURCE '/aws/rds/instance/${DB_INSTANCE_ID}/slowquery\\n| filter @message like /Query_time/\\n| parse @message \"# Query_time: * Lock_time: * Rows_sent: * Rows_examined: *\" as query_time, lock_time, rows_sent, rows_examined\\n| stats count() as slow_queries, avg(query_time) as avg_qtime by bin(1m)",
        "stacked": false, "view": "timeSeries"
      }
    }
  ]
}
__CW_JSON__
; DASH_BODY="$(REGION="$REGION" BROKER_NAME="$BROKER_NAME" CANARY_NAME="$CANARY_NAME" DB_RESOURCE_ID="$DB_RESOURCE_ID" DB_INSTANCE_ID="$DB_INSTANCE_ID" envsubst <"$TMP")"; \
aws cloudwatch put-dashboard --region "$REGION" --dashboard-name "$DASH_NAME" --dashboard-body "$DASH_BODY" && echo "Created/updated: $DASH_NAME in $REGION"
