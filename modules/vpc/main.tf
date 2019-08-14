resource "aws_vpc" "main" {
  cidr_block           = "${var.VPC_CIDR}"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "main"
  }
}
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_db_subnet_group" "default" {
  name        = "main_subnet_group"
  description = "Our main group of subnets"
  subnet_ids  = ["${aws_subnet.subnet_1.id}", "${aws_subnet.subnet_2.id}"]
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.SUBNET_1_CIDR}"
  availability_zone = "${var.AZ_1}"
  #  associate_public_ip_address = "true"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.SUBNET_2_CIDR}"
  availability_zone = "${var.AZ_2}"
  #  associate_public_ip_address = "true"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "subnet2"
  }
}

resource "aws_security_group" "postgres" {
  name   = "postgres_rds_sg"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["${var.VPC_CIDR}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "postgres"
  }
}

resource "aws_security_group" "ec2" {
  name   = "ec2_sg"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "TCP"
    cidr_blocks = ["${var.VPC_CIDR}"]
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
