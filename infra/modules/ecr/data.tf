data "aws_ecr_lifecycle_policy_document" "this" {
  /**
    * This rule is added to ensure that recently tagged images are kept and untagged images are deleted after a certain number of days.
    * The priority of this rule is set to 1, which means it will be evaluated before the second rule.
    */
  rule {
    priority    = 1
    description = "Keep recently tagged images and delete untagged images ${var.delete_untagged_after_days} of days."
    selection {
      tag_status      = "tagged"
      tag_prefix_list = ["sha-"]
      count_type      = "imageCountMoreThan"
      count_number    = var.keep_tagged_images
    }
    action {
      type = "expire"
    }
  }
  /**
    * This rule is added to ensure that untagged images are deleted after a certain number of days.
    * It is important to note that this rule will only apply to untagged images, and it will not affect tagged images.
    * The priority of this rule is set to 2, which means it will be evaluated after the first rule.
    */
  rule {
    priority    = 2
    description = "Delete untagged images after ${var.delete_untagged_after_days} days."
    selection {
      tag_status   = "untagged"
      count_type   = "sinceImagePushed"
      count_unit   = "days"
      count_number = var.delete_untagged_after_days
    }
    action {
      type = "expire"
    }
  }
}
