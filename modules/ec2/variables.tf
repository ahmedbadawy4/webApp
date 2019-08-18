variable "INSTANCE_TYPE" {
  description = "instance_type"
}

variable "KEY_NAME" {
  description = "key_name"
}

variable "VOLUME_SIZE" {
  description = "root volume size"
}

variable "EC2_SUBNET" {
  description = "subnet id come from vpc module"
  type        = "string"
}

variable "EC2_SG" {
  description = "security group ID come from vpc module"
}

variable "ALLOW_EC2_ROLE_NAME" {
  description = "allow ec2 role name"
}

