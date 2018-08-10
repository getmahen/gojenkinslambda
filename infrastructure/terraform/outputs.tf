output "lambda_arn" {
  value = "${aws_lambda_function.checkipaddress.arn}"
}

output "lambda_function_name" {
  value = "${aws_lambda_function.checkipaddress.function_name}"
}

output "lambda_function_version" {
  value = "${aws_lambda_function.checkipaddress.version}"
}

output "lambda_function_version_metadata" {
  value = "${data.aws_s3_bucket_object.checkipaddress_pkg.metadata}"
}
