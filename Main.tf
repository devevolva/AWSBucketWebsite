###############################################################################
# 
# S3 STATIC WEBSITE
#
###############################################################################

# REGION ######################################################################
provider "aws" {
    region = "us-east-1"
}



# BUCKET ######################################################################
resource "aws_s3_bucket" "devevolvaweb" {
  bucket           = "devevolvaweb"
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



# FILES #######################################################################
resource "aws_s3_bucket_object" "indexHtml" {
  bucket       = "devevolvaweb"
  key          = "index.html"
  acl          = "public-read"
  source       = "website\\index.html"
  etag         = "${md5(file("website\\index.html"))}"
  content_type = "text/html"
  depends_on   = ["aws_s3_bucket.devevolvaweb"] 
}

resource "aws_s3_bucket_object" "errorHtml" {
  bucket       = "devevolvaweb"
  key          = "error.html"
  acl          = "public-read"
  source       = "website\\error.html"
  etag         = "${md5(file("website\\error.html"))}"
  content_type = "text/html"
  depends_on   = ["aws_s3_bucket.devevolvaweb"]
}

resource "aws_s3_bucket_object" "mainCss" {
  bucket       = "devevolvaweb"
  key          = "main.css"
  acl          = "public-read"
  source       = "website\\main.css"
  etag         = "${md5(file("website\\main.css"))}"
  content_type = "text/css"
  depends_on   = ["aws_s3_bucket.devevolvaweb"]
}

resource "aws_s3_bucket_object" "normalizeCss" {
  bucket       = "devevolvaweb"
  key          = "normalize.css"
  acl          = "public-read"
  source       = "website\\normalize.css"
  etag         = "${md5(file("website\\normalize.css"))}"
  content_type = "text/css"
  depends_on   = ["aws_s3_bucket.devevolvaweb"]
}

resource "aws_s3_bucket_object" "scriptsJs" {
  bucket       = "devevolvaweb"
  key          = "scripts.js"
  acl          = "public-read"
  source       = "website\\scripts.js"
  etag         = "${md5(file("website\\scripts.js"))}"
  content_type = "text/javascript"
  depends_on   = ["aws_s3_bucket.devevolvaweb"]
}



# OTUPUTS #####################################################################
output "webBucketARN" {
      value = "${aws_s3_bucket.devevolvaweb.arn}"
  }
output "webBucketName" {
      value = "${aws_s3_bucket.devevolvaweb.bucket}"
  }

output "webBucketId" {
      value = "${aws_s3_bucket.devevolvaweb.id}"
  }

output "webBucketURL" {
      value = "${aws_s3_bucket.devevolvaweb.bucket}.s3-website-${aws_s3_bucket.devevolvaweb.region}.amazonaws.com"
  }
