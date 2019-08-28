resource "aws_db_instance" "default" {
  identifier             = "${var.IDENTIFIER}"
  allocated_storage      = "${var.ALLOCATED_STORAGE}"
  engine                 = "${var.ENGINE}"
  engine_version         = "${lookup(var.ENGINE_VERSION, var.ENGINE)}"
  instance_class         = "${var.INSTANCE_CLASS}"
  name                   = "${var.DB_NAME}"
  username               = "${var.DB_USERNAME}"
  password               = "${var.DB_PASSWORD}"
  vpc_security_group_ids = ["${var.DB_SG_ID}"]
  db_subnet_group_name   = "${var.DB_SUBNET_ID}"
  skip_final_snapshot    = "true"
  publicly_accessible    = "true"
}
