variable "identifier" {
  default     = "mydb-rds"
  description = "Identifier for DB"
}

variable "allocated_storage" {
  default     = "20"
  description = "Storage size in GB"
}

variable "engine" {
  default     = "postgres"
  description = "Engine type"
}

variable "engine_version" {
  description = "Engine version"

  default = {
   postgres =  "9.6.8"
}
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "db_name" {
  default     = "mydb"
  description = "db name"
}

variable "username" {
  default     = "myuser"
  description = "User name"
}

variable "password" {
  description = "password"
  default     = "password123"
}
variable "project" {
  description = "project name"
  default     = "gfg-app"
}
#variable "vpc_id" {
#  description = "Your VPC ID"
#  default     = "${aws_vpc.rds.id}"
#}
variable "cidr_blocks" {
  default     = "0.0.0.0/0"
  description = "CIDR for sg"
}

variable "sg_name" {
  default     = "rds_sg"
  description = "Tag Name for sg"
}
variable "subnet_1_cidr" {
  default     = "10.0.1.0/24"
  description = " first AZ"
}

variable "subnet_2_cidr" {
  default     = "10.0.2.0/24"
  description = "second AZ"
}

variable "az_1" {
  default     = "us-west-1b"
  description = "first Az"
}

variable "az_2" {
  default     = "us-west-1a"
  description = "second Az2"
}

