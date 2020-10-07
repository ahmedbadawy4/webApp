output "ec2role_name" {
  value = "${aws_iam_role.rds.name}"
}
output "pg_password" {
  value = "${random_password.pg.result}"
}
