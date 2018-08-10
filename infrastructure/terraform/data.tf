data "aws_s3_bucket_object" "checkipaddress_pkg" {
  bucket = "testjenkinsartifacts"
  key    = "checkipaddress.zip"
}

data "aws_lambda_function" "checkipaddress_data" {
  function_name = "checkipaddress"
}
