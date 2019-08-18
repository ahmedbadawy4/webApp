variable "IDENTIFIER" {
  default     = "gfgdb-rds"
  description = "Identifier for DB"
}

variable "ALLOCATED_STORAGE" {
  default     = "20"
  description = "allocated_storage size in GB"
}

variable "ENGINE" {
  default     = "postgres"
  description = "Engine type"
}

variable "ENGINE_VERSION" {
  description = "Engine version"

  default = {
    postgres = "9.6.11"
  }
}

variable "INSTANCE_CLASS" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "DB_NAME" {
  default     = "gfgdb"
  description = "db name"
}

variable "DB_USERNAME" {
  default     = "gfguser"
  description = "User name"
}

variable "DB_PASSWORD" {
  description = "password"
  default     = "password123"
}

variable "DB_SG_ID" {
  description = "postgres security group id"
}

variable "DB_SUBNET_ID" {
  description = "postgress group subnet id "
}
