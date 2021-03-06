resource "aws_lambda_function" "checkipaddress" {
  s3_bucket     = "${data.aws_s3_bucket_object.checkipaddress_pkg.bucket}"//"testjenkinsartifacts"
  s3_key        = "${data.aws_s3_bucket_object.checkipaddress_pkg.key}"//"checkipaddress.zip"
  s3_object_version = "${data.aws_s3_bucket_object.checkipaddress_pkg.version_id}"
  function_name = "checkipaddress"
  runtime       = "go1.x"
  handler       = "checkipaddress"
  role          = "${aws_iam_role.checkipaddress_role.arn}"
  timeout       = 10
  description   = "Test Lambda function"
  publish       = true
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

//ALIAS for Lambda
resource "aws_lambda_alias" "checkipaddress_alias" {
  name             = "checkipaddressalias"
  description      = "a sample description"
  function_name    = "${aws_lambda_function.checkipaddress.arn}"
  function_version = "1"//"${data.aws_lambda_function.checkipaddress_data.version}"//"1"
  # routing_config   = {
  #   additional_version_weights = {
  #     "2" = 0.5
  #   }
  # }
}