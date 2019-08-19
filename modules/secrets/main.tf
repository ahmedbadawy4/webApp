resource "aws_kms_key" "rds_kms" {
  description         = "KMS key to encyrept rds master password"
}
resource "aws_kms_alias" "rds_alias_kms" {
  name          = "${var.KMS_ALIAS_NAME}"
  target_key_id = "${aws_kms_key.rds_kms.key_id}"
}

resource "aws_ssm_parameter" "pg_password" {
  name        = "pg_password"
  description = "adding postgress password in parameter store"
  type        = "SecureString"
  value       = "${var.DB_PASSWORD}"
  key_id      = "${aws_kms_key.rds_kms.key_id}"
}


resource "aws_iam_policy" "SSMRead" {
  name        = "ssmReadOnly"
  description = "Allow get, describe and list parameters store"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:Describe*",
                "ssm:Get*",
                "ssm:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "kmsEncryptDecrept" {
  name        = "kmsEncryptDecrept"
  description = "Allow encrypt and decrept on rds_kms"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
      "Action": [
        "kms:Decrypt",
        "kms:Encrypt"
      ],
      "Effect": "Allow",
      "Resource": "${aws_kms_key.rds_kms.arn}"
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
}

resource "aws_iam_role_policy_attachment" "policy1Attachment" {
  role       = "${aws_iam_role.allow_ec2_role.name}"
  policy_arn = "${aws_iam_policy.SSMRead.arn}"
}
resource "aws_iam_role_policy_attachment" "policy2Attachment" {
  role       = "${aws_iam_role.allow_ec2_role.name}"
  policy_arn = "${aws_iam_policy.kmsEncryptDecrept.arn}"
}

