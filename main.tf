provider "aws" {
  region  = "us-east-1"
  profile = "gfg"
}

module "vpc" {
  source = "./modules/vpc"
  AZ_1   = "us-east-1a"
  AZ_2   = "us-east-1b"

}

module "rds" {
  source            = "./modules/rds"
  IDENTIFIER        = "gfg-rds"
  ALLOCATED_STORAGE = "16"
  ENGINE            = "postgres"
  INSTANCE_CLASS    = "db.t2.micro"
  DB_USERNAME       = "gfguser"
  DB_PASSWORD       = "${module.secrets.pg_password}"
  DB_SG_ID          = "${module.vpc.sg_postgres_id}"
  DB_SUBNET_ID      = "${module.vpc.default_subnet_group_id}"
}

module "ec2" {
  source        = "./modules/ec2/"
  INSTANCE_TYPE = "t2.micro"
  KEY_NAME      = "aws"
  VOLUME_SIZE   = "16"
  EC2_SUBNET    = "${module.vpc.subnet1_id}"
  EC2_SG        = "${module.vpc.sg_ec2_id}"
  EC2ROLE_NAME  = "${module.secrets.ec2role_name}"

}

module "secrets" {
  source         = "./modules/secrets/"
  DB_PASSWORD    = "${module.rds.db_password}"
  KMS_ALIAS_NAME = "alias/rds-key-alias"
}
