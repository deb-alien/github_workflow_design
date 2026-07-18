/**
  ** Create the ECS task execution role
  ** This role is assumed by the ECS agent to pull images and send logs to CloudWatch.
  ** It is also granted permissions to decrypt secrets from SSM Parameter Store.
  ** The execution role is not used by the application itself, only by the ECS agent.
  */
resource "aws_iam_role" "execution" {
  name               = local.execution_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  tags               = merge(local.common_tags, { Name = local.execution_role_name })
}

/**
  ** Create the ECS task runtime role
  ** This role is assumed by the ECS agent to run the application container.
  ** It is granted permissions to decrypt secrets from SSM Parameter Store and access S3 bucket objects.
  */
resource "aws_iam_role" "task" {
  name               = local.task_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  tags               = merge(local.common_tags, { Name = local.task_role_name })
}
