###############################################################################
# 
# S3 STATIC WEBSITE
#
###############################################################################

###############################################################################
# TERRAFORM ###################################################################
terraform {
  required_version = ">= 0.11.11"
}


###############################################################################
# PROVIDERS ###################################################################
provider "aws" {
    region  = "us-east-1"
    version = "~> 1.56"
}


###############################################################################
# BUCKET ######################################################################
variable "bucketName" {
  description = "Bucket used to hold backup files."
  default = "web-bucket-demo"
}

resource "aws_s3_bucket" "web-bucket" {
  bucket           = "${var.bucketName}"
  acl              = "public-read"
  policy           = "${file("s3_website_policy.json")}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning {
    enabled        = false
  }
}


###############################################################################
# FILES #######################################################################
resource "aws_s3_bucket_object" "indexHtml" {
  bucket       = "${var.bucketName}"
  key          = "index.html"
  acl          = "public-read"
  source       = "website\\index.html"
  etag         = "${md5(file("website\\index.html"))}"
  content_type = "text/html"
  depends_on   = ["aws_s3_bucket.web-bucket"] 
}

resource "aws_s3_bucket_object" "errorHtml" {
  bucket       = "${var.bucketName}"
  key          = "error.html"
  acl          = "public-read"
  source       = "website\\error.html"
  etag         = "${md5(file("website\\error.html"))}"
  content_type = "text/html"
  depends_on   = ["aws_s3_bucket.web-bucket"]
}

resource "aws_s3_bucket_object" "mainCss" {
  bucket       = "${var.bucketName}"
  key          = "main.css"
  acl          = "public-read"
  source       = "website\\main.css"
  etag         = "${md5(file("website\\main.css"))}"
  content_type = "text/css"
  depends_on   = ["aws_s3_bucket.web-bucket"]
}

resource "aws_s3_bucket_object" "normalizeCss" {
  bucket       = "${var.bucketName}"
  key          = "normalize.css"
  acl          = "public-read"
  source       = "website\\normalize.css"
  etag         = "${md5(file("website\\normalize.css"))}"
  content_type = "text/css"
  depends_on   = ["aws_s3_bucket.web-bucket"]
}

resource "aws_s3_bucket_object" "scriptsJs" {
  bucket       = "${var.bucketName}"
  key          = "scripts.js"
  acl          = "public-read"
  source       = "website\\scripts.js"
  etag         = "${md5(file("website\\scripts.js"))}"
  content_type = "text/javascript"
  depends_on   = ["aws_s3_bucket.web-bucket"]
}


###############################################################################
# OTUPUTS #####################################################################
output "webBucketARN" {
      value = "${aws_s3_bucket.web-bucket.arn}"
  }
output "webBucketName" {
      value = "${aws_s3_bucket.web-bucket.bucket}"
  }

output "webBucketId" {
      value = "${aws_s3_bucket.web-bucket.id}"
  }

output "webBucketURL" {
      value = "${aws_s3_bucket.web-bucket.bucket}.s3-website-${aws_s3_bucket.web-bucket.region}.amazonaws.com"
  }
