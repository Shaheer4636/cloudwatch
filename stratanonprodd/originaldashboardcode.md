aws cloudwatch put-dashboard \
  --region "$REGION" \
  --dashboard-name "AmazonMQ (strata-uat)" \
  --dashboard-body file:cw-dashboard.json
