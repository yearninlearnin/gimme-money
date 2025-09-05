resource "google_artifact_registry_repository" "docker_repo" {
  location      = "europe-west6"
  repository_id = "gimme-money"
  description   = "Docker repo for Cloud Run images"
  format        = "DOCKER"
  
  # This prevents Terraform from trying to recreate if it exists
  lifecycle {
    prevent_destroy = true
  }
}




resource "google_cloud_run_service" "gimme-money" {
  name     = "gimme-money"
  location = "europe-west6"
  
  template {
    spec {
      containers {
        image = "europe-west6-docker.pkg.dev/akiramenaide-dev/gimme-money/my-app:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
  
  # Wait for Docker image to be pushed before deploying
#   depends_on = [
#     docker_registry_image.run_app

  
}

resource "google_cloud_run_service_iam_member" "member" {
  location = google_cloud_run_service.gimme-money.location
  project  = google_cloud_run_service.gimme-money.project
  service  = google_cloud_run_service.gimme-money.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}