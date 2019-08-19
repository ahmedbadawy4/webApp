output "Ec2_public_ip" {
  value = "${aws_instance.amazone_ec2.public_ip}"
}
