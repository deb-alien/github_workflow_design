/**
  * Attach the application policy to the ECS task IAM role
*/
resource "aws_iam_role_policy_attachment" "application" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.application.arn
}

/**
  * Attach the AmazonRDSEnhancedMonitoringRole policy to the RDS Monitoring IAM role
*/
resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring_role_policy_attachment" {
  role       = aws_iam_role.rds_enhanced_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
