/**
  * Create RDS Monitoring IAM role for RDS Enhanced Monitoring
*/
resource "aws_iam_role" "rds_enhanced_monitoring_role" {
  name = local.rds_monitoring_role_name

  assume_role_policy = data.aws_iam_policy_document.rds_monitoring_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name = local.rds_monitoring_role_name
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
