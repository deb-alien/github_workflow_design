/**
  ** Attach the AWS managed policy for ECS task execution
  ** Allows Fargate agent to pull images from ECR & stream logs
  ** This policy allows the ECS agent to pull container images from ECR and send logs to CloudWatch.
*/
resource "aws_iam_role_policy_attachment" "execution_core" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

/**
  ** Attach the custom policy for SSM Parameter Store access
  ** Target the resource ARN to decrypt secret boot parameters
  ** This policy allows the ECS agent to decrypt secrets from SSM Parameter Store.
*/
resource "aws_iam_role_policy_attachment" "execution_secrets" {
  role       = aws_iam_role.execution.name
  policy_arn = aws_iam_policy.secrets_access.arn
}

/**
  ** Attach the custom policy for SSM Parameter Store access
  ** Grants application code access to read internal non-secrets
  ** This policy allows the application code running in the ECS task to decrypt secrets from SSM Parameter Store.
*/
resource "aws_iam_role_policy_attachment" "task_secrets" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.secrets_access.arn
}

/**
  ** Attach the custom policy for S3 bucket access
  ** Grants application code access to active storage assets
  ** This policy allows the application code running in the ECS task to access specific S3 bucket objects.
*/
resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.s3_access.arn
}
