# AWS S3 Static Web Hosting

## Using

Terraform v0.11.13 + provider.aws v1.56.0 

Powershell v5.1.17763.316

<br />

## Description

Host a website using an AWS S3 bucket configured to serve static web pages.

:warning: Be sure to replace the bucketName default with your own unique bucket name.
``` ruby
variable "bucketName" {
  description = "Bucket used to hold backup files."
  default = "web-bucket-demo" # Replace with your unique bucket name.
}
```

<br />

#### Browse Website
Replace "web-bucket-demo" with your unique bucket name:

    https://web-bucket-demo.s3-website-us-east-1.amazonaws.com