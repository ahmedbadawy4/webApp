variable "INSTANCE_TYPE" {
  description = "instance_type"
}

variable "KEY_NAME" {
  description = "key_name"
}

variable "VOLUME_SIZE" {
  description = "root volume size"
}

variable "EC2_SUBNET_ID" {
  description = "subnet id come from vpc module"
}

variable "EC2_SG_ID" {
  description = "security group ID come from vpc module"
}