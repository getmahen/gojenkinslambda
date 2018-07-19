resource "aws_lambda_function" "checkipaddress" {
  s3_bucket     = "testjenkinsartifacts"
  s3_key        = "checkipaddress.zip"
  function_name = "checkipaddress"
  runtime       = "go1.x"
  handler       = "checkipaddress"
  role          = "${aws_iam_role.checkipaddress_role.arn}"
  timeout       = 10
  description   = "Test Lambda function"
}

resource "aws_iam_role" "checkipaddress_role" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
