/**
  ** Attach the AmazonECSTaskExecutionRolePolicy to the ECS task execution role.
  ** This policy allows ECS tasks to pull images from ECR and send logs to CloudWatch.
*/
resource "aws_iam_role_policy_attachment" "execution" {
  role       = aws_iam_role.execution.name
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
