

# Cloud Run
output "vue_bootstrap_cloudrun_env" {
  description = "Cloud Run - Envronment."
  value       = google_cloud_run_service.vue-bootstrap-cloudrun-env
}
