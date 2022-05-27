
# Manage Terraform state remotely in a Storage bucket.
terraform {
  backend "gcs" {
    bucket = "vue-bootstrap-state-dev-dwu9ink4gayjw4a"
    prefix = "terraform"
  }
}
