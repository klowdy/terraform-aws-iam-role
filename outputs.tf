output "arn" {
  description = "The ARN of the IAM role"
  value       = concat(aws_iam_role.this.*.arn, [""])[0]
}

output "name" {
  description = "The name of the IAM role"
  value       = concat(aws_iam_role.this.*.name, [""])[0]
}

output "instance_profile_arn" {
  description = "The ARN of the IAM instance profile"
  value       = concat(aws_iam_instance_profile.this.*.arn, [""])[0]
}

output "instance_profile_name" {
  description = "The AnameRN of the IAM instance profile"
  value       = concat(aws_iam_instance_profile.this.*.name, [""])[0]
}
