terraform {
  backend "s3" {
    bucket = "my-eyad-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }



}