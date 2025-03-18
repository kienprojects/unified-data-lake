resource "aws_cloudwatch_log_group" "madhatter-log_group" {
  name              = "/aws/data-lake/logs"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_stream" "madhatter-log_stream" {
  name           = "data-lake-log-stream"
  log_group_name = aws_cloudwatch_log_group.madhatter-log_group.name
}

resource "aws_cloudwatch_metric_alarm" "madhatter-cpu_alarm" {
  alarm_name          = "high_cpu_utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.db.id
  }

  alarm_actions = [
    "arn:aws:sns:us-west-2:123456789012:madhatter_sns_topic"
  ]
}

resource "aws_sns_topic" "madhatter_sns_topic" {
  name = "madhatter_sns_topic"
}
