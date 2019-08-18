provider "aws" {
  region  = "us-west-1"
  profile = "gfg"
}

#####
# DB
#####
module "vpc" {
  source = "./modules/vpc"

}
module "postgres" {
  source            = "./modules/postgres"
  IDENTIFIER        = "gfg-rds"
  ALLOCATED_STORAGE = "16"
  ENGINE            = "postgres"
  INSTANCE_CLASS    = "db.t2.micro"
  DB_USERNAME       = "gfguser"
  DB_PASSWORD       = "dbpassword"
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
  EC2ROLE_NAME  = "${module.secret.ec2role_name}"

}

module "secret" {
  source = "./modules/secrets/"
}
