/**
Create and manage projects, folders, and their relationships.
*/

# Query Relevant Project
data "google_project" "vue-bootstrap-env" {
  project_id = "${var.project}"
}

# Deploy Cloud Run Service
resource "google_cloud_run_service" "vue-bootstrap-cloudrun-env" {
  name     = "${var.environment}"
  location = "${var.location}"
  project = "${var.project}"

  template {
    spec {
      containers {

        image = "${var.image}"

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
  location    = google_cloud_run_service.vue-bootstrap-cloudrun-env.location
  project     = google_cloud_run_service.vue-bootstrap-cloudrun-env.project
  service     = google_cloud_run_service.vue-bootstrap-cloudrun-env.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
