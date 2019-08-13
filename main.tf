provider "aws" {
  region  = "us-west-1"
  profile = "gfg"
}

#####
# DB
#####

module "postgres" {
  source = "./modules/postgres"
  identifier             = "gfg-rds"
  engine                 = "postgres"
  instance_class         = "db.t2.micro"
  username               = "gfguser"
  password               = "dbpassword"
}
module "ec2" {
  source = "./modules/ec2/"

}
