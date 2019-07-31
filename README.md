# terraform-gfg
# Terraform Exercise

We want to see a basic web application displaying content from a database. This can be as simple as a 'Hello World'.

## Repository and Coding Standard

You have two weeks time to complete this exercise and can create as many PRs as you want. I will review every PR and give you feedback
if you want. You will run the terraform code in your own AWS account and we will reimburse you with 25$ as soon as possible that you don't have any extra costs because of the exercise.

It's very important for us to have a good code style, so please run `terraform fmt -recursive` in the top level directory to format your terraform
code according to the HashiCorp standards.

*Basics:*

- Create a new repository on GitHub and work in a `development` branch
- Run `terraform fmt` before you submit a PR
- Create a new VPC and setup all the dependencies to get a module which we can try out on our side
- Create a terraform module and make it configurable where you think it makes sense, but provide defaults
- Provide an environment where you run your module and provide non-secrect variables

## Components overview

### KMS Key

- Create a KMS key and alias to encrypt the secret for RDS
- Adjust the policy to allow the EC2 instance to access it later on

### RDS Database

- Create a PostgreSQL database (db.t2.micro)
- Engine version of your choice
- 20GB Storage
- No backups
- Have terraform create a secure password without special characters and store it as an encrypted secret in the EC2 parameter store (Hint: Have a look at the terraform provider list)
- Make the database publicly available, but assign a security group which only allows the security group itself and the EC2 instance you will create later

### EC2 instance

- Create a key pair to login to the instance via SSH
- Create an IAM instance role with `arn:aws:iam::aws:policy/ReadOnlyAccess` to be able to pull the secret from the EC2 parameter store
- Create an EC2 instance (t2.micro) with a 16GB root block device
- Use the Amazon-Linux 2 AMI
- Create a security group which opens Port 80 and 22 to 0.0.0.0 to be able to access your instance from outside
- Deploy a web application in any language you prefer and fetch content from a table of the RDS instance, bonus points for using Ansible to do the deploy
- Fetch the database password from the EC2 parameter store once and store for further use via the AWS cli (Preinstalled): `aws ssm get-parameter <parameter-name> --with-decryption`

### Modifications

If you don't want to use an EC2 instance, the use of ECS, Fargate or Lambda Functions with an API Gateway is perfectly fine, too. We're already using terraform 0.12, so doing the exercise
in the new syntax would be tremendous plus. As a hint: IntelliJ in the community version + the terraform plugin is a huge help 
