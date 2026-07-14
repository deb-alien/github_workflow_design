/**
  ** Create an IAM role for ECS tasks with the necessary trust relationship and tags.
  ** This role is used by ECS tasks to assume the necessary permissions for accessing AWS resources.
*/
resource "aws_iam_role" "execution" {
  name               = local.execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  tags               = merge(local.common_tags, { Name = local.execution_role_name })
}

/**
  ** Create an IAM role for ECS tasks with the necessary trust relationship and tags.
  ** This role is used by ECS tasks to assume the necessary permissions for accessing AWS resources.
*/
resource "aws_iam_role" "task" {
  name               = local.task_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  tags               = merge(local.common_tags, { Name = local.task_role_name })
}
