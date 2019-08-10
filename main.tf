provider "aws" {
  region  = "us-west-1"
  profile = "gfg"
}

#####
# DB
#####

module "aws-postgress-rds" {
  source = "./modules/aws-postgress-rds"
  identifier             = "gfg-rds"
  engine                 = "postgres"
  instance_class         = "db.t2.micro"
  username               = "gfguser"
  password               = "dbpassword"
}

