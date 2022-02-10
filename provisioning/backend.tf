terraform {
  backend "s3" {
    bucket = "karthikeyan-atc-assessment-tf-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}