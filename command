########################################
# Output (unchanged)
########################################
output "what_is_cluster_member" {
  value = module.rds_aurora.cluster_members
}

########################################
# CPU Utilization (unchanged)
########################################
resource "aws_cloudwatch_metric_alarm" "CPUUtilizationAlertPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s High (Alert) RDS %s CPUUtilization", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.CPUUtilization_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.CPUUtilization_Alert_period
  statistic           = "Average"
  threshold           = var.CPUUtilization_Alert_threshold
  alarm_description   = "Average database CPU utilization over 80% last 5 minutes too high."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.high_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "CPUUtilizationAlert" {
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "High (Alert)", "RDS", local.identifier_eng_app_env, "CPUUtilization"])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.CPUUtilization_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.CPUUtilization_Alert_period
  statistic           = "Average"
  threshold           = var.CPUUtilization_Alert_threshold
  alarm_description   = "Average database CPU utilization over 80% last 5 minutes too high."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.high_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

resource "aws_cloudwatch_metric_alarm" "CPUUtilizationCRITICALPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s CRITICAL (SEVERE) RDS %s CPUUtilization", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.CPUUtilization_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.CPUUtilization_Critical_period
  statistic           = "Average"
  threshold           = var.CPUUtilization_Critical_threshold
  alarm_description   = "Average database CPU utilization over ${var.CPUUtilization_Critical_threshold}% last 5 minutes too high."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "CPUUtilizationCRITICAL" {
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "CRITICAL (SEVERE)", "RDS", local.identifier_eng_app_env, "CPUUtilization"])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.CPUUtilization_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.CPUUtilization_Critical_period
  statistic           = "Average"
  threshold           = var.CPUUtilization_Critical_threshold
  alarm_description   = "Average database CPU utilization over ${var.CPUUtilization_Critical_threshold}% last 5 minutes too high."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

########################################
# Read Latency (unchanged)
########################################
resource "aws_cloudwatch_metric_alarm" "ReadLatencyPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s CRITICAL (SEVERE) RDS %s ReadLatency", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.ReadLatency_evaluation_periods
  metric_name         = "ReadLatency"
  namespace           = "AWS/RDS"
  period              = var.ReadLatency_period
  statistic           = "Average"
  threshold           = var.ReadLatency_threshold
  alarm_description   = "Average database ReadLatency is too high."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "ReadLatency" {
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "CRITICAL (SEVERE)", "RDS", local.identifier_eng_app_env, "ReadLatency"])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.ReadLatency_evaluation_periods
  metric_name         = "ReadLatency"
  namespace           = "AWS/RDS"
  period              = var.ReadLatency_period
  statistic           = "Average"
  threshold           = var.ReadLatency_threshold
  alarm_description   = "Average database ReadLatency is too high."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

########################################
# Freeable Memory (unchanged)
########################################
resource "aws_cloudwatch_metric_alarm" "FreeableMemoryPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s CRITICAL (SEVERE) RDS %s FreeableMemory", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.FreeableMemory_evaluation_periods
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = var.FreeableMemory_period
  statistic           = "Average"
  threshold           = var.FreeableMemory_threshold
  alarm_description   = "Average database FreeableMemory is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "FreeableMemory" {
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "CRITICAL (SEVERE)", "RDS", local.identifier_eng_app_env, "FreeableMemory"])
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.FreeableMemory_evaluation_periods
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = var.FreeableMemory_period
  statistic           = "Average"
  threshold           = var.FreeableMemory_threshold
  alarm_description   = "Average database FreeableMemory is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

########################################
# Write Latency (unchanged)
########################################
resource "aws_cloudwatch_metric_alarm" "WriteLatencyPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s CRITICAL (SEVERE) RDS %s WriteLatency", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.WriteLatency_evaluation_periods
  metric_name         = "WriteLatency"
  namespace           = "AWS/RDS"
  period              = var.WriteLatency_period
  statistic           = "Average"
  threshold           = var.WriteLatency_threshold
  alarm_description   = "Average database WriteLatency is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "WriteLatency" {
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "CRITICAL (SEVERE)", "RDS", local.identifier_eng_app_env, "WriteLatency"])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.WriteLatency_evaluation_periods
  metric_name         = "WriteLatency"
  namespace           = "AWS/RDS"
  period              = var.WriteLatency_period
  statistic           = "Average"
  threshold           = var.WriteLatency_threshold
  alarm_description   = "Average database WriteLatency is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.critical_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

########################################
# Read/Write Throughput — MODIFIED to reduce flapping
########################################

# PER-INSTANCE — ReadThroughput (warning)
resource "aws_cloudwatch_metric_alarm" "ReadThroughputPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s medium (warning) RDS %s ReadThroughput", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.ReadThroughput_evaluation_periods
  datapoints_to_alarm = var.throughput_datapoints_to_alarm
  metric_name         = "ReadThroughput"
  namespace           = "AWS/RDS"
  period              = var.ReadThroughput_period
  statistic           = "Average"
  threshold           = var.ReadThroughput_threshold
  alarm_description   = "Average database ReadThroughput is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.medium_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

# SINGLE/CLUSTER-ID — ReadThroughput (warning)
resource "aws_cloudwatch_metric_alarm" "ReadThroughput" {
  count               = var.enable_throughput_alarm == true ? 1 : 0
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "medium (warning)", "RDS", local.identifier_eng_app_env, "ReadThroughput"])
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.ReadThroughput_evaluation_periods
  datapoints_to_alarm = var.throughput_datapoints_to_alarm
  metric_name         = "ReadThroughput"
  namespace           = "AWS/RDS"
  period              = var.ReadThroughput_period
  statistic           = "Average"
  threshold           = var.ReadThroughput_threshold
  alarm_description   = "Average database ReadThroughput is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.medium_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

# PER-INSTANCE — WriteThroughput (warning)
resource "aws_cloudwatch_metric_alarm" "WriteThroughputPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s medium (warning) RDS %s WriteThroughput", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.WriteThroughput_evaluation_periods
  datapoints_to_alarm = var.throughput_datapoints_to_alarm
  metric_name         = "WriteThroughput"
  namespace           = "AWS/RDS"
  period              = var.WriteThroughput_period
  statistic           = "Average"
  threshold           = var.WriteThroughput_threshold
  alarm_description   = "Average database WriteThroughput is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.medium_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

# SINGLE/CLUSTER-ID — WriteThroughput (warning)
resource "aws_cloudwatch_metric_alarm" "WriteThroughput" {
  count               = var.enable_throughput_alarm == true ? 1 : 0
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "medium (warning)", "RDS", local.identifier_eng_app_env, "WriteThroughput"])
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.WriteThroughput_evaluation_periods
  datapoints_to_alarm = var.throughput_datapoints_to_alarm
  metric_name         = "WriteThroughput"
  namespace           = "AWS/RDS"
  period              = var.WriteThroughput_period
  statistic           = "Average"
  threshold           = var.WriteThroughput_threshold
  alarm_description   = "Average database WriteThroughput is too low."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.medium_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

########################################
# DB Load (unchanged)
########################################
resource "aws_cloudwatch_metric_alarm" "DBLoadTooHighPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s High (Alert) RDS %s DBLoadTooHigh", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.DBLoad_High_evaluation_periods
  metric_name         = "DBLoad"
  namespace           = "AWS/RDS"
  period              = var.DBLoad_High_period
  statistic           = "Average"
  threshold           = var.DBLoad_High_threshold
  alarm_description   = "Average database load was too high over the last 10 minutes"
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.high_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "DBLoadTooHigh" {
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "High (Alert)", "RDS", local.identifier_eng_app_env, "DBLoadTooHigh"])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.DBLoad_High_evaluation_periods
  metric_name         = "DBLoad"
  namespace           = "AWS/RDS"
  period              = var.DBLoad_High_period
  statistic           = "Average"
  threshold           = var.DBLoad_High_threshold
  alarm_description   = "Average database load was too high over the last 10 minutes"
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.high_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}

########################################
# Rollback Segment History (unchanged; typo fixed earlier)
########################################
resource "aws_cloudwatch_metric_alarm" "RollbackSegmentHistoryListLengthPerInst" {
  count               = var.single_rds_inst ? 1 : 2
  alarm_name          = format("%s %s %s High (Alert) RDS %s RollbackSegmentHistoryListLength", var.env, var.appname, local.account_id, local.cluster_members[count.index])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.RollbackSegmentHistory_evaluation_periods
  metric_name         = "RollbackSegmentHistoryListLength"
  namespace           = "AWS/RDS"
  period              = var.RollbackSegmentHistory_period
  statistic           = "Average"
  threshold           = var.RollbackSegmentHistory_threshold
  alarm_description   = "Count of undo logs that record committed transactions with delete-marked records greater than threshold."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.high_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.cluster_members[count.index]
  }
}

resource "aws_cloudwatch_metric_alarm" "RollbackSegmentHistoryListLength" {
  alarm_name          = join(" ", [var.env, var.appname, local.account_id, "High (Alert)", "RDS", local.identifier_eng_app_env, "RollbackSegmentHistoryListLength"])
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.RollbackSegmentHistory_evaluation_periods
  metric_name         = "RollbackSegmentHistoryListLength"
  namespace           = "AWS/RDS"
  period              = var.RollbackSegmentHistory_period
  statistic           = "Average"
  threshold           = var.RollbackSegmentHistory_threshold
  alarm_description   = "Count of undo logs that record committed transactions with delete-marked records greater than threshold."
  alarm_actions       = [join("", ["arn:aws:sns:", var.region, ":", local.account_id, ":", var.high_notification_sns])]
  treat_missing_data  = "notBreaching"
  tags                = local.tags

  dimensions = {
    DBInstanceIdentifier = local.identifier_eng_app_env
  }
}
