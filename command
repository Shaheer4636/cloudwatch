cat > mqdashboard.json <<'JSON'
{"widgets":[
  {"type":"text","x":0,"y":0,"width":24,"height":2,
   "properties":{"markdown":"# Amazon MQ (Strata-idev)"}},

  {"type":"metric","x":0,"y":2,"width":6,"height":6,
   "properties":{"title":"Total producers","view":"singleValue","region":"us-east-1",
     "metrics":[["AWS/AmazonMQ","TotalProducerCount","Broker","*",{"stat":"Maximum"}]]}},
  {"type":"metric","x":6,"y":2,"width":6,"height":6,
   "properties":{"title":"Total consumers","view":"singleValue","region":"us-east-1",
     "metrics":[["AWS/AmazonMQ","TotalConsumerCount","Broker","*",{"stat":"Maximum"}]]}},
  {"type":"metric","x":12,"y":2,"width":12,"height":6,
   "properties":{"title":"CPU utilization per broker (%)","view":"timeSeries","region":"us-east-1","stat":"Average",
     "metrics":[["AWS/AmazonMQ","CpuUtilization","Broker","*"]]}},
  {"type":"metric","x":0,"y":8,"width":12,"height":6,
   "properties":{"title":"Heap usage per broker (%)","view":"timeSeries","region":"us-east-1","stat":"Average",
     "metrics":[["AWS/AmazonMQ","HeapUsage","Broker","*"]]}},
  {"type":"metric","x":12,"y":8,"width":12,"height":6,
   "properties":{"title":"Storage limit usage per broker (%)","view":"timeSeries","region":"us-east-1","stat":"Average",
     "metrics":[["AWS/AmazonMQ","StorePercentUsage","Broker","*"]]}},
  {"type":"metric","x":0,"y":14,"width":12,"height":6,
   "properties":{"title":"Network In/Out (bytes)","view":"timeSeries","region":"us-east-1",
     "metrics":[["AWS/AmazonMQ","NetworkIn","Broker","*",{"id":"m1"}],[".","NetworkOut",".","*",{"id":"m2"}]]}},
  {"type":"metric","x":12,"y":14,"width":12,"height":6,
   "properties":{"title":"Queue size by queue","view":"timeSeries","region":"us-east-1",
     "metrics":[["AWS/AmazonMQ","QueueSize","Broker","*","Queue","*"]]}}
],
"start":"-PT3H","periodOverride":"auto"}
JSON

jq . mqdashboard.json
aws cloudwatch put-dashboard --dashboard-name AmazonMQ-Strata-idev --dashboard-body file://mqdashboard.json
