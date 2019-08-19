output "ec2role_name" {
  value = "${aws_iam_role.rds.name}" 
}
