resource "aws_kms_key" "rds" {
  description             = "KMS key for rds"
  deletion_window_in_days = 30
}
resource "aws_kms_alias" "rds" {
  name          = "alias/rds-key-alias"
  target_key_id = "${aws_kms_key.rds.key_id}"
}

resource "aws_ssm_parameter" "dbpassword" {
  name        = "dbpassword"
  description = "RDS secret"
  type        = "SecureString"
  value       = "dbpasswd"
  key_id      = "${aws_kms_key.rds.key_id}"
}


resource "aws_iam_policy" "SSMReadOnlyAccess" {
  name   = "gfgssmReadOnlyAccess"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "ec2policy"
  description = "IAM policy to allow encrypt and decrept"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt"
      ],
      "Effect": "Allow",
      "Resource": "${aws_kms_key.rds.arn}"
    }
  ]}
EOF
}

resource "aws_iam_role" "rds" {
  name               = "ec2role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    tag-key = "ec2_role"
  }
}

resource "aws_iam_role_policy_attachment" "policy1Attachment" {
  role       = "${aws_iam_role.rds.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
resource "aws_iam_role_policy_attachment" "policy2Attachment" {
  role       = "${aws_iam_role.rds.name}"
  policy_arn = "${aws_iam_policy.SSMReadOnlyAccess.arn}"
}

