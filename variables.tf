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

variable "description" {
  description = "A description for the IAM role"
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

variable "force_detach_policies" {
  description = "Forces the policies to be detached before destroying the role"
  type        = bool
  default     = false
}

variable "max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour (3600 seconds) to 12 hours (43200)"
  type        = number
  default     = 3600
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
