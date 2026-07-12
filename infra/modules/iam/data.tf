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
