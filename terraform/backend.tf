terraform {
  backend "s3" {
    bucket         = "isaac-terraform-state-238851097968"
    key            = "weather-app/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}