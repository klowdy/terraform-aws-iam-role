#~~~~~~~~~~
# Control
#~~~~~~~~~~
variable "create" {
  description = "Controls resource creation"
  type        = bool
  default     = false
}

variable "is_instance_profile" {
  description = "Determines if the IAM role will be associated to an IAM instance profile"
  type        = bool
  default     = false
}

#~~~~~~~
# Role
#~~~~~~~
variable "name" {
  description = "The name of the role"
  default     = ""
}

variable "path" {
  description = "Path under which the role resides"
  default     = "/"
}

variable "trust_policy" {
  description = "The trust policy for this role"
  default     = ""
}

variable "customer_policies" {
  description = "A list of maps defining role policies to be attached to the IAM role"
  type        = list(object({
    name        = string
    description = string
    policy      = string
  }))
  default     = []
}

variable "managed_policy_arns" {
  description = "A list of AWS Managed Role Policy ARNs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to apply to the IAM role"
  type        = map(string)
  default     = {}
}
