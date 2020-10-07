# Terraform Exercise 


### Hello world App with Ec2 and PostgreSQL on AWS

- Terraform infrastructure code to provision fully operated environment consists of EC2 act as an application and PostgreSQL database 
- The all components are in the same vpc with no public access for the database except from and to Ec2 private subnet and Ec2 is only public accessible on 80 and 22 from anywhere.  

- The code made consists of a modules to easily reuse it 

- the secrets and password can be managed by kms and parameter store.

- EC2 has only Read only access to this parameters and kms encryption and decryption 


## Usage

1- install [terraform](https://terraform.io/downloads.html).

2- install [awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).

3- [Set up your AWS account](https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180#a9b0).

4- create keypair for example `[ec2_key.pem]` to make Ec2 accessable. 
 `notes: it should be in the same region where we will create our environment`

5- setup your local machine to access your AWS account:
```
 aws configure 

# and answer to the questions by the the key and secret ID and default region 

```
6- provision the environment
```
 # clone the github repository 
 git clone https://github.com/ahmedbadawy4/gfg-webApp.git)
 cd gfg-webApp
     # edit your variables in main.tf
 terraform init
 terraform plan  
     # check the what will changed or created on your environment 
 terraform Apply 
     # reply with yes if everything is ok
```
7- get ec2 public ip from the outputs
 
```
terraform output Ec2_public_ip    # to get Ec2 public IP
terraform output db_host          # to et Ec2 Host
```

7- Get the master database password 

```
# Assume region is us West (N. California), we need to list all parameters 

aws ssm describe-parameters --region "us-west-1"

aws ssm get-parameter --name "<parameter_name>" --region "us-west-1" --with-decryption

# the "Value": "<database_password>"
```

8- connect to the database

```
psql --host=<databasehost> --port=5432 --username=<database_user> --password --dbname=<database_name>

```

## TO Do List:
add an application on our Ec2 to can retrieve and write data to or from our database.
