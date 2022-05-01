# Primary Cluster
module "primary-cluster" {
  name                    = "primary"
  project_id              = var.project_id
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster"
  version                 = "20.0.0"
  regional                = false
  region                  = var.primary_region
  network                 = var.vpc_name
  subnetwork              = "subnet-gke1"
  ip_range_pods           = ""
  ip_range_services       = ""
  zones                   = var.primary_zones
  release_channel         = "REGULAR"
  cluster_resource_labels = { "mesh_id" : "proj-${var.project_number}" }
  istio                   = true
  cloudrun                = true
  node_pools = [
    {
        name              = "gke1-nodepool"        
        autoscaling       = false
        auto_repair       = true
        auto_upgrade      = true
        node_count        = 1
        disk_size_gb      = 100
        disk_type         = "pd-standard"        
        machine_type      = "n1-standard-4"        
    },    
  ]
}

# Secondary Cluster
module "secondary-cluster" {
  name                    = "secondary"
  project_id              = var.project_id
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/beta-public-cluster"
  version                 = "20.0.0"
  regional                = false
  region                  = var.secondary_region
  network                 = var.vpc_name
  subnetwork              = "subnet-gke2"
  ip_range_pods           = ""
  ip_range_services       = ""
  zones                   = var.secondary_zones
  release_channel         = "REGULAR"
  cluster_resource_labels = { "mesh_id" : "proj-${var.project_number}" }
  istio                   = true
  cloudrun                = true
  node_pools = [
    {
        name              = "gke2-nodepool"        
        autoscaling       = false
        auto_repair       = true
        auto_upgrade      = true
        node_count        = 1
        disk_size_gb      = 100
        disk_type         = "pd-standard"
        machine_type      = "n1-standard-4"
    },
  ]
}