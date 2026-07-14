/**
  * Create RDS Monitoring IAM policy document for RDS Enhanced Monitoring
*/
data "aws_iam_policy_document" "rds_monitoring_assume_role" {
  statement {
    sid    = "AllowRDSMonitoringToAssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}
