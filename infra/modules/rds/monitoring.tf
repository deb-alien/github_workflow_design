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

/**
  * Create RDS Monitoring IAM role for RDS Enhanced Monitoring
*/
resource "aws_iam_role" "rds_enhanced_monitoring_role" {
  name = "${var.project_name}-${var.environment}-rds-monitoring-role"

  assume_role_policy = data.aws_iam_policy_document.rds_monitoring_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-rds-monitoring-role"
    }
  )
}

/**
  * Attach the AmazonRDSEnhancedMonitoringRole policy to the RDS Monitoring IAM role
*/
resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring_role_policy_attachment" {
  role       = aws_iam_role.rds_enhanced_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
