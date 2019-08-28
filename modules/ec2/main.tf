data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2role"
  role = "${var.EC2ROLE_NAME}"
}

resource "aws_instance" "amazone_ec2" {
  ami                    = "${data.aws_ami.amazon-linux-2.id}"
  instance_type          = "${var.INSTANCE_TYPE}"
  key_name               = "${var.KEY_NAME}"
  subnet_id              = "${var.EC2_SUBNET}"
  vpc_security_group_ids = ["${var.EC2_SG}"]
  iam_instance_profile   = "${aws_iam_instance_profile.ec2_profile.name}"
  user_data              = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install postgresql -y
              EOF
  root_block_device {
    volume_size           = "${var.VOLUME_SIZE}"
    delete_on_termination = "true"
  }
  tags = {
    Name = "gfg"
  }
}

