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
    {{"title":"Amazon MQ (Strata-idev)","description":"This dashboard visualizes the activity level of your Amazon MQ broker, so you can understand the volume of your messaging and see whether consumers are keeping up with producers. For more information about Amazon MQ:\n\n- [Amazon MQ integration documentation](https://docs.datadoghq.com/integrations/amazon_mq/)\n\n- [Monitoring Amazon MQ with Datadog](https://www.datadoghq.com/blog/monitor-amazonmq-metrics-with-datadog/)\n\nClone this template dashboard to make changes and add your own graph widgets. (cloned)","widgets":[{"id":0,"layout":{"x":1,"y":15,"width":18,"height":10},"definition":{"title":"Total producers","title_size":"16","title_align":"left","time":{"live_span":"30m"},"type":"query_value","requests":[{"response_format":"scalar","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.producer_count.maximum{$scope}.as_count()","aggregator":"max"}]}],"autoscale":true,"custom_links":[],"precision":0}},{"id":1,"layout":{"x":1,"y":26,"width":18,"height":10},"definition":{"title":"Total consumers","title_size":"16","title_align":"left","time":{"live_span":"30m"},"type":"query_value","requests":[{"response_format":"scalar","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.consumer_count.maximum{$scope}.as_count()","aggregator":"max"}]}],"autoscale":true,"custom_links":[],"precision":0}},{"id":2,"layout":{"x":34,"y":92,"width":44,"height":17},"definition":{"title":"CPU utilization per broker (%)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"avg:aws.amazonmq.cpu_utilization{$scope,$broker} by {broker}"}],"style":{"palette":"warm","line_type":"solid","line_width":"normal"},"display_type":"line"}],"custom_links":[]}},{"id":3,"layout":{"x":124,"y":56,"width":44,"height":17},"definition":{"title":"Queue size per queue (messages)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.queue_size{$scope,$broker,$queue,$topic} by {queue}.as_count()"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":4,"layout":{"x":5,"y":96,"width":44,"height":17},"definition":{"title":"Heap usage per broker (%)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"avg:aws.amazonmq.heap_usage{$scope,$broker} by {broker}"}],"style":{"palette":"cool","line_type":"solid","line_width":"normal"},"display_type":"line"}],"custom_links":[]}},{"id":5,"layout":{"x":34,"y":38,"width":44,"height":17},"definition":{"title":"Total messages sent per destination","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.enqueue_count{$scope,$broker,$queue,$topic} by {queue}.as_count()"},{"data_source":"metrics","name":"query2","query":"sum:aws.amazonmq.enqueue_count{$scope,$broker,$queue,$topic} by {topic}.as_count()"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query2)"}],"style":{"palette":"green","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":6,"layout":{"x":34,"y":56,"width":44,"height":17},"definition":{"title":"Total messages received per destination","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.dequeue_count{$scope,$broker,$queue,$topic} by {topic}.as_count()"},{"data_source":"metrics","name":"query2","query":"sum:aws.amazonmq.dequeue_count{$scope,$broker,$queue,$topic} by {queue}.as_count()"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query2)"}],"style":{"palette":"purple","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":7,"layout":{"x":21,"y":1,"width":12,"height":35},"definition":{"type":"note","content":"Broker resource metrics","background_color":"blue","font_size":"18","text_align":"center","show_tick":true,"tick_pos":"50%","tick_edge":"right"}},{"id":8,"layout":{"x":79,"y":91,"width":44,"height":17},"definition":{"title":"Total consumers per broker","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.total_consumer_count{$scope,$broker} by {broker}"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":9,"layout":{"x":79,"y":1,"width":44,"height":17},"definition":{"title":"Storage limit usage per broker (%)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"avg:aws.amazonmq.store_percent_usage{$scope,$broker} by {broker}"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"area"}],"custom_links":[]}},{"id":10,"layout":{"x":124,"y":1,"width":44,"height":17},"definition":{"title":"Network in per broker (bytes)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"avg:aws.amazonmq.network_in{$scope,$broker} by {broker}"}],"style":{"palette":"green","line_type":"solid","line_width":"normal"},"display_type":"line"}],"custom_links":[]}},{"id":11,"layout":{"x":124,"y":19,"width":45,"height":17},"definition":{"title":"Network out per broker (bytes)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"avg:aws.amazonmq.network_out{$scope,$broker} by {broker}"}],"style":{"palette":"purple","line_type":"solid","line_width":"normal"},"display_type":"line"}],"custom_links":[]}},{"id":12,"layout":{"x":21,"y":38,"width":12,"height":53},"definition":{"type":"note","content":"Destination metrics","background_color":"blue","font_size":"18","text_align":"center","show_tick":true,"tick_pos":"50%","tick_edge":"right"}},{"id":13,"layout":{"x":124,"y":38,"width":44,"height":17},"definition":{"title":"Expired count per destination (messages)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.expired_count{$scope,$broker,$queue,$topic} by {topic}.as_count()"},{"data_source":"metrics","name":"query2","query":"sum:aws.amazonmq.expired_count{$scope,$broker,$queue,$topic} by {queue}.as_count()"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query2)"}],"style":{"palette":"warm","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":14,"layout":{"x":1,"y":1,"width":18,"height":12},"definition":{"type":"image","url":"/static/images/logos/amazon-mq_avatar.svg","sizing":"fit","margin":"large"}},{"id":15,"layout":{"x":79,"y":56,"width":44,"height":17},"definition":{"title":"Subscribed consumers per destination","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.consumer_count{$scope,$broker,$queue,$topic} by {topic}.as_count()"},{"data_source":"metrics","name":"query2","query":"sum:aws.amazonmq.consumer_count{$scope,$broker,$queue,$topic} by {queue}.as_count()"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query2)"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":16,"layout":{"x":79,"y":38,"width":44,"height":17},"definition":{"title":"Producers per destination","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.producer_count{$scope,$broker,$queue,$topic} by {topic}.as_count()"},{"data_source":"metrics","name":"query2","query":"sum:aws.amazonmq.producer_count{$scope,$broker,$queue,$topic} by {queue}.as_count()"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query2)"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":17,"layout":{"x":1,"y":46,"width":18,"height":9},"definition":{"title":"Clean shutdown","title_size":"16","title_align":"left","time":{"live_span":"30m"},"type":"query_value","requests":[{"response_format":"scalar","queries":[{"data_source":"metrics","name":"query1","query":"max:aws.amazonmq.journal_files_for_fast_recovery{$scope,$broker,$queue,$topic}","aggregator":"max"}]}],"autoscale":true,"custom_links":[],"precision":2}},{"id":18,"layout":{"x":1,"y":56,"width":18,"height":9},"definition":{"title":"Unclean shutdown","title_size":"16","title_align":"left","time":{"live_span":"30m"},"type":"query_value","requests":[{"response_format":"scalar","queries":[{"data_source":"metrics","name":"query1","query":"max:aws.amazonmq.journal_files_for_full_recovery{*}","aggregator":"max"}]}],"autoscale":true,"custom_links":[],"precision":0}},{"id":19,"layout":{"x":1,"y":38,"width":18,"height":7},"definition":{"type":"note","content":"Journal files to be replayed on broker restart","background_color":"pink","font_size":"14","text_align":"center","show_tick":true,"tick_pos":"50%","tick_edge":"bottom"}},{"id":20,"layout":{"x":124,"y":74,"width":44,"height":17},"definition":{"title":"Broker message latency per destination (ms)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"avg:aws.amazonmq.enqueue_time{$scope,$broker,$queue,$topic} by {topic}"},{"data_source":"metrics","name":"query2","query":"avg:aws.amazonmq.enqueue_time{$scope,$broker,$queue,$topic} by {queue}"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query2)"}],"style":{"palette":"cool","line_type":"solid","line_width":"normal"},"display_type":"line"}],"custom_links":[]}},{"id":21,"layout":{"x":34,"y":74,"width":44,"height":17},"definition":{"title":"Total messages sent to consumers","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.dispatch_count{$scope,$broker,$topic,$queue} by {topic}.as_count()"},{"data_source":"metrics","name":"query2","query":"sum:aws.amazonmq.dispatch_count{$scope,$broker,$topic,$queue} by {queue}.as_count()"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query2)"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"bars"}],"custom_links":[]}},{"id":22,"layout":{"x":79,"y":74,"width":44,"height":17},"definition":{"title":"Avg memory limit usage per destination (%)","title_size":"16","title_align":"left","show_legend":false,"legend_size":"0","type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"avg:aws.amazonmq.memory_usage{$scope,$broker,$queue,$topic} by {topic}"}],"formulas":[{"formula":"exclude_null(query1)"},{"formula":"exclude_null(query1)"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"area"}],"custom_links":[]}},{"id":2057308989656493,"layout":{"x":34,"y":1,"width":45,"height":17},"definition":{"title":"","title_size":"16","title_align":"left","show_legend":false,"type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.ack_rate{*}.as_count()"}],"formulas":[{"formula":"query1"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"line"}]}},{"id":2811700833410312,"layout":{"x":79,"y":19,"width":44,"height":17},"definition":{"title":"","title_size":"16","title_align":"left","show_legend":false,"type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"data_source":"metrics","name":"query1","query":"sum:aws.amazonmq.publish_rate{*}.as_count()"}],"formulas":[{"formula":"query1"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"line"}]}},{"id":7903856420107510,"layout":{"x":34,"y":19,"width":44,"height":17},"definition":{"title":"","title_size":"16","title_align":"left","show_legend":false,"type":"timeseries","requests":[{"response_format":"timeseries","queries":[{"name":"query1","data_source":"metrics","query":"avg:aws.amazonmq.enqueue_time{*}"}],"formulas":[{"formula":"query1"}],"style":{"palette":"dog_classic","line_type":"solid","line_width":"normal"},"display_type":"line"}]}}],"template_variables":[{"name":"scope","available_values":[],"default":"*"},{"name":"broker","prefix":"broker","available_values":[],"default":"*"},{"name":"queue","prefix":"queue","available_values":[],"default":"*"},{"name":"topic","prefix":"topic","available_values":[],"default":"*"}],"layout_type":"free","notify_list":[],"template_variable_presets":[{"name":"Strata-idev-RabbitMQ","template_variables":[{"name":"scope","value":"application_name:strata-idev-rabbitmq"}]}]}
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
