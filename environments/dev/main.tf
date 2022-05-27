/**
Create and manage projects, folders, and their relationships.
*/

terraform {
  required_providers {
    gcp = {
      source  = "hashicorp/google"
      version = "4.21.0"
    }
  }
}

# Query Relevant Project
data "google_project" "vue-bootstrap-dev" {
  project_id = "vue-bootstrap-dev"
}

# Deploy Cloud Run Service
resource "google_cloud_run_service" "vue-bootstrap-cloudrun-dev" {
  name     = "vue-bootstrap-cloudrun-dev"
  location = "us-central1"
  project = data.google_project.vue-bootstrap-dev.project_id

  template {
    spec {
      containers {

        image = "us-docker.pkg.dev/vue-bootstrap-dev/releases/vue-bootstrap:v1.1.0"

        ports {
          container_port = 80
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Policy - Allow Public Access
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# Grant Public Access
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.vue-bootstrap-cloudrun-dev.location
  project     = google_cloud_run_service.vue-bootstrap-cloudrun-dev.project
  service     = google_cloud_run_service.vue-bootstrap-cloudrun-dev.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

