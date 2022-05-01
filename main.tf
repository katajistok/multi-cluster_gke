provider "google" {
  project = var.project_id
  region  = var.primary_region  
  credentials = file("fi-katajistok-test-project-7efabf1fc23e.json")
}

provider "google-beta" {
  project = var.project_id
  region  = var.primary_region  
  credentials = file("fi-katajistok-test-project-7efabf1fc23e.json")
}