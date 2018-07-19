data "aws_s3_bucket_object" "checkipaddress_pkg" {
  bucket = "testjenkinsartifacts"
  key    = "checkipaddress.zip"
}
