aws cloudwatch list-metrics --namespace AWS/AmazonMQ --metric-name CpuUtilization --region us-east-1 --max-items 5

# If empty, try your actual region (e.g. us-west-2)
aws cloudwatch list-metrics --namespace AWS/AmazonMQ --metric-name CpuUtilization --region us-west-2 --max-items 5
