/**
** Create an IAM policy document for ECS task role trust relationship.
*/
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    sid    = "AllowEcsTasksToAssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

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

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}
