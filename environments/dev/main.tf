/**
Create a Cloud Run service in the Development environment.
*/

terraform {
  required_providers {
    gcp = {
      source  = "hashicorp/google"
      version = "4.21.0"
    }
  }
}

module "cloud_run_service" {
  source       = "../../modules/cloud_run_service"
  project      = "${var.project}"
  environment  = "${var.environment}"
  image        = "${var.image}"
}
