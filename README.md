# AWS S3 Static Web Hosting
***
Terraform v0.11.13 + provider.aws v1.56.0 
<br />
Powershell v5.1.17763.316
***
Host a website using an AWS S3 bucket configured to serve static web pages.

Be sure to replace the bucketName default with your own unique bucket name.

```
variable "bucketName" {
  description = "Bucket used to hold backup files."
  default = "web-bucket-demo" # Replace with your unique bucket name.
}

```