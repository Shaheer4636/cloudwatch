{
  "widgets": [
    {
      "type": "metric",
      "x": 0, "y": 0, "width": 12, "height": 6,
      "properties": {
        "region": "REGION",
        "title": "RabbitMQ Ack & Confirm rate",
        "view": "timeSeries",
        "stat": "Sum",
        "period": 60,
        "metrics": [
          ["AWS/AmazonMQ", "AckRate", "Broker", "BROKER_NAME"],
          ["AWS/AmazonMQ", "ConfirmRate", "Broker", "BROKER_NAME"]
        ]
      }
    },
    {
      "type": "metric",
      "x": 12, "y": 0, "width": 12, "height": 6,
      "properties": {
        "region": "REGION",
        "title": "strata.file.download (Canary Success %)",
        "view": "timeSeries",
        "stat": "Average",
        "period": 60,
        "metrics": [
          ["CloudWatchSynthetics", "SuccessPercent", "CanaryName", "strata-file-download"]
        ],
        "yAxis": { "left": { "min": 0, "max": 100 } }
      }
    },
    {
      "type": "metric",
      "x": 0, "y": 6, "width": 12, "height": 6,
      "properties": {
        "region": "REGION",
        "title": "MySQL DB load (AAS)",
        "view": "timeSeries",
        "stat": "Average",
        "period": 60,
        "metrics": [
          [
            { "expression": "DB_PERF_INSIGHTS('RDS','DB_RESOURCE_ID','db.load.avg')", "label": "DBLoad (AAS)", "id": "e1" }
          ]
        ]
      }
    },
    {
      "type": "metric",
      "x": 12, "y": 6, "width": 12, "height": 6,
      "properties": {
        "region": "REGION",
        "title": "Total Requests by Version (from logs)",
        "view": "timeSeries",
        "stat": "Sum",
        "period": 60,
        "metrics": [
          [
            {
              "expression": "SEARCH('{App/HTTP,Service,Version} MetricName=\"Requests\"', 'Sum', 60)",
              "label": "Requests by {Service}/{Version}",
              "id": "q1"
            }
          ]
        ]
      }
    },
    {
      "type": "log",
      "x": 0, "y": 12, "width": 24, "height": 6,
      "properties": {
        "region": "REGION",
        "title": "MySQL Slow queries & avg Query_time (Logs Insights)",
        "query": "SOURCE '/aws/rds/instance/DB_INSTANCE_ID/slowquery'\n| filter @message like /Query_time/\n| parse @message \"# Query_time: * Lock_time: * Rows_sent: * Rows_examined: *\" as query_time, lock_time, rows_sent, rows_examined\n| stats count() as slow_queries, avg(query_time) as avg_qtime by bin(1m)",
        "stacked": false,
        "view": "timeSeries"
      }
    }
  ]
}



aws cloudwatch put-dashboard \
  --region REGION \
  --dashboard-name strata-runtime \
  --dashboard-body file://cloudwatch-dashboard.json
