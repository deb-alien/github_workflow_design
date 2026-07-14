/**
  ** Attach the AmazonECSTaskExecutionRolePolicy to the ECS task execution role.
  ** This policy allows ECS tasks to pull images from ECR and send logs to CloudWatch.
*/
resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

/**
  ** Attach the application policy to the ECS task IAM role
  ** This policy grants the ECS task permissions to access SSM parameters, KMS decryption, and S3 bucket operations.
*/
resource "aws_iam_role_policy_attachment" "application" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.application.arn
}
