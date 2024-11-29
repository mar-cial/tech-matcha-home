terraform {
    backend "s3" {
    bucket = "tech-matcha-state-files"
    key = "apps/homepage/state.tf"
    region = "us-east-1"
}
}
