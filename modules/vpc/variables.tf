variable "VPC_CIDR" {
  default     = "10.0.0.0/16"
  description = "CIDR for vpc"
}

variable "SUBNET_1_CIDR" {
  default     = "10.0.1.0/24"
  description = "subnet for the first Availability Zone"
}

variable "SUBNET_2_CIDR" {
  default     = "10.0.2.0/24"
  description = "subnet for the second Availability Zone"
}


variable "AZ_1" {
  default     = "us-west-1b"
  description = "first Availability Zone"
}

variable "AZ_2" {
  default     = "us-west-1a"
  description = "second Availability Zone"
}

