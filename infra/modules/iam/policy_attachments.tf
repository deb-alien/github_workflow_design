/**
  * Attach the application policy to the ECS task IAM role
*/
resource "aws_iam_role_policy_attachment" "application" {
  role       = aws_iam_role.task.name
  policy_arn = aws_iam_policy.application.arn
}


