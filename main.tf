resource "aws_iam_role" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  description = var.description
  path        = var.path

  assume_role_policy    = var.trust_policy
  force_detach_policies = var.force_detach_policies
  
  max_session_duration = var.max_session_duration

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags
  )
}

resource "aws_iam_instance_profile" "this" {
  count = var.create && var.is_instance_profile ? 1 : 0

  name = var.name
  role = aws_iam_role.this[0].name
}

#~~~~~~~~~~~~~~~~~~~~
# Customer policies
#~~~~~~~~~~~~~~~~~~~~
resource "aws_iam_policy" "customer" {
  count = var.create && length(var.customer_policies) > 0 ? length(var.customer_policies) : 0

  path        = var.path
  name        = lookup(var.customer_policies[count.index], "name", "tf_undefined")
  description = lookup(var.customer_policies[count.index], "description", "tf_undefined")
  policy      = lookup(var.customer_policies[count.index], "policy", "tf_undefined")
}

resource "aws_iam_role_policy_attachment" "customer" {
  count = var.create && length(var.customer_policies) > 0 ? length(var.customer_policies) : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.customer[count.index].arn
}

#~~~~~~~~~~~~~~~~~~~
# Managed policies
#~~~~~~~~~~~~~~~~~~~
data "aws_iam_policy" "managed" {
  count = var.create && length(var.managed_policy_arns) > 0 ? length(var.managed_policy_arns) : 0
  arn   = var.managed_policy_arns[count.index]
}

resource "aws_iam_role_policy_attachment" "managed" {
  count = var.create && length(var.managed_policy_arns) > 0 ? length(var.managed_policy_arns) : 0

  role       = aws_iam_role.this[0].name
  policy_arn = data.aws_iam_policy.managed[count.index].arn
}
