
# Cloud Run Service
output "vue_bootstrap_cloudrun_env" {
  description = "Cloud Run - Environment."
  value       = "${module.cloud_run_service}"
}