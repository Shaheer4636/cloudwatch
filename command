We added a single knob throughput_datapoints_to_alarm (default 3) and applied it to all ReadThroughput and WriteThroughput alarms (per-instance and cluster).

This makes an alarm fire only after 3 consecutive breaching datapoints within the existing evaluation window; periods/thresholds remain unchanged.

Kept statistic = Average and treat_missing_data = "notBreaching" to avoid bounces during short gaps or idle time; explicitly set ok_actions = [] to stop recovery spam.

Fixed a small typo in the RollbackSegmentHistory alarm (statistic) so plans run cleanly.

No changes to CPU, Latency, FreeableMemory, DBLoad alarms, SNS topics, or identifiers—scope limited to throughput noise.

Expected result: fewer “medium/warning” pages caused by transient spikes; alerts reflect sustained throughput degradation.

If we need tighter/looser sensitivity, adjust only throughput_datapoints_to_alarm (e.g., 2 for faster alerting, 4 for stricter).

Validated with terraform fmt/validate/plan; diffs show only the throughput alarms and the new variable.
