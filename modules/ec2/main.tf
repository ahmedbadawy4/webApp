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
  root_block_device {
    volume_size           = "${var.VOLUME_SIZE}"
    delete_on_termination = "true"
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
