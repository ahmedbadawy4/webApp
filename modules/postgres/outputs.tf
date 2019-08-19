output "db_instance_id" {
  value = "${aws_db_instance.default.id}"
}

output "db_instance_address" {
  value = "${aws_db_instance.default.address}"
}

output "db_password" {
  value = "${var.DB_PASSWORD}"
}
