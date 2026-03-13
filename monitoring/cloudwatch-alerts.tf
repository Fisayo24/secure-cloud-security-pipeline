resource "aws_cloudwatch_log_group" "pipeline_logs" {
  name              = "/secure-pipeline/logs"
  retention_in_days = 30
}

resource "aws_cloudwatch_metric_alarm" "s3_security_alarm" {
  alarm_name          = "secure-pipeline-s3-access"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "NumberOfObjects"
  namespace           = "AWS/S3"
  period              = 300
  statistic           = "Average"
  threshold           = 1000

  alarm_description = "Alert if unusual activity occurs in the secure pipeline S3 bucket"

  dimensions = {
    BucketName = "secure-pipeline-logs-demo-12345"
  }
}
