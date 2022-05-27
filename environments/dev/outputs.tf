

# Cloud Run
output "vue_bootstrap_cloudrun_dev" {
  description = "Cloud Run - Dev."
  value       = google_cloud_run_service.vue-bootstrap-cloudrun-dev
}
