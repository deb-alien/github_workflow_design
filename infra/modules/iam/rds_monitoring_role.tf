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
