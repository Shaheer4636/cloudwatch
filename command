cat > mqdashboard.json <<'JSON'
{"widgets":[
  {"type":"text","x":0,"y":0,"width":24,"height":2,
   "properties":{"markdown":"# Amazon MQ (Strata-idev)"}},
  {"type":"metric","x":0,"y":2,"width":6,"height":6,
   "properties":{"title":"Total producers","view":"singleValue","region":"us-east-1",
     "metrics":[["AWS/AmazonMQ","TotalProducerCount","Broker","*",{"stat":"Maximum"}]]}},
  {"type":"metric","x":6,"y":2,"width":6,"height":6,
   "properties":{"title":"Total consumers","view":"singleValue","region":"us-east-1",
     "metrics":[["AWS/AmazonMQ","TotalConsumerCount","Broker","*",{"stat":"Maximum"}]]}}
],
"start":"-PT3H","periodOverride":"auto"}
JSON



jq . mqdashboard.json
aws cloudwatch put-dashboard --dashboard-name AmazonMQ-Strata-idev --dashboard-body file://mqdashboard.json
