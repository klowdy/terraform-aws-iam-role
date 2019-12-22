# IAM Role

Creates an IAM role with role and trust policy attachments

## Purpose

This module is designed to simplify and standardise the creation of AWS IAM Roles and the attachment of IAM Role Policies with Terraform

It _is not_ designed to tackle the complexities of creating IAM Role Policies.  You still need to create these and supply them as inputs to this module

## Role Policy Types

This module supports both **Customer Managed Policies** and **AWS Managed Policies**

## Suggested Implementation

The below snippet is the suggested implementation for creating an IAM role with an associated Instance Profile

```hcl
module "iam_role" {
  source = "klowdy/iam-role/aws"

  create              = true
  is_instance_profile = true
  name                = "MyAwesomeIAMRole"
  description         = "IAM Role to do something"

  force_detach_policies = true
  max_session_duration  = 43200


  trust_policy = concat(data.aws_iam_policy_document.MyTrustPolicy.*.json, [""])[0]

  role_policies = [
    {
      name        = "MyAwesomeIAMRolePolicy"
      description = "A customer managed IAM Policy document"
      policy      = concat(data.aws_iam_policy_document.MyAwesomeIAMRolePolicy.*.json, [""])[0]
    },
    {
      name        = "MyRenderedRolePolicy"
      description = "Another customer managed IAM Policy document"
      policy      = concat(data.template_file.MyRenderedRolePolicy.*.rendered, [""])[0]
    },
    {
      # Keep going if you like
    }
  ]

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "..."
  ]
}
```

The above implementation assumes you're using Terraform Data Sources to create the IAM role and trust policies

```hcl
# Role policy
data "aws_iam_policy_document" "MyTrustPolicy" {
  count = var.create_policies ? 1 : 0

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["something.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Role policy
data "aws_iam_policy_document" "MyAwesomeIAMRolePolicy" {
  count = var.create_policies ? 1 : 0

  statement {
    effect    = "Allow"
    actions   = ["s3:ListBuckets"]
    resources = ["*"]
  }
  
  ...
}

data "template_file" "MyRenderedRolePolicy" {
  template = "${file("${path.module}/role-policy.tpl")}"

  vars = {
    something_dynamic = "${var.something_dynamic}"
  }
}
```
