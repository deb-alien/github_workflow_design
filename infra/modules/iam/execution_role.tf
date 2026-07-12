/**
** Create an IAM role for ECS task execution with the necessary trust relationship and tags.
*/
resource "aws_iam_role" "task_execution_role" {
  name               = "${local.name_prefix}-ecs-task-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  tags               = local.common_tags
}


/**
** Attach the AmazonECSTaskExecutionRolePolicy to the ECS task execution role.
** This policy allows ECS tasks to pull images from ECR and send logs to CloudWatch.
*/
resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
