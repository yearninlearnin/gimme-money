# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = "akiramenaide-dev"
  region  = "europe-west6"
  credentials = "gcpkey.json"
}