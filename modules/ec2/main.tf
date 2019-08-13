data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners      = ["amazon"]

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}
resource "aws_security_group" "ec2" {
  name        = "ec2_sg"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-05091f2bfaf266c2b"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
#    cidr_blocks = ["${var.cidr_blocks}"]
    cidr_blocks = ["10.0.0.0/16"] #### change to be ${var.vpc_cidr} from rds module and port 5432
  }

ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2"
  }
}

resource "aws_instance" "amazone_ec2" {
  ami                      = "${data.aws_ami.amazon-linux-2.id}"
# ami                      = "ami-ebd02392"
  instance_type            = "t2.micro"
  key_name		   = "aws"
  subnet_id                = "subnet-0aae04930b052aedd"
  vpc_security_group_ids   = ["${aws_security_group.ec2.id}"]
  root_block_device {
    volume_size            = "16" #####"${var.ec2_volume_size}"
    delete_on_termination  = "true" #####"${var.delete_on_termination}"
  }
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, From ec2" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "ec2"
  }
}
