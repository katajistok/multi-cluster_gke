resource "google_compute_network" "sandbox-network" {
    auto_create_subnetworks         = false
    delete_default_routes_on_create = false
    name                            = "${var.vpc_name}"
    routing_mode                    = "REGIONAL"    
}

resource "google_compute_route" "default" {
    description      = "Default route to the Internet."
    dest_range       = "0.0.0.0/0"
    name             = "default-route-52158fff026c456c"
    network          = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc_name}"
    next_hop_gateway = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/gateways/default-internet-gateway"
    priority         = 1000
    project          = var.project_id
    tags             = []
    depends_on = [
        google_compute_network.sandbox-network
    ]    
}

resource "google_compute_global_address" "google-managed-services-sandbox-network" {
    address            = "10.119.240.0"
    address_type       = "INTERNAL"
    description        = "IP Range for peer networks."
    name               = "google-managed-services-sandbox-network"
    network            = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc_name}"
    prefix_length      = 20
    project            = var.project_id
    purpose            = "VPC_PEERING"
    depends_on = [
        google_compute_network.sandbox-network
    ]
    timeouts {}
}

resource "google_compute_subnetwork" "subnet-gke1" {
    ip_cidr_range            = "172.16.13.0/28"
    name                     = "subnet-gke1"
    network                  = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc_name}"
    private_ip_google_access = true
    region                   = "europe-north1"
    depends_on = [
        google_compute_network.sandbox-network
    ]
    timeouts {}
}

resource "google_compute_subnetwork" "subnet-gke2" {
    ip_cidr_range            = "172.16.14.0/28"
    name                     = "subnet-gke2"
    network                  = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${var.vpc_name}"
    private_ip_google_access = true
    region                   = "us-central1"
    depends_on = [
        google_compute_network.sandbox-network
    ]
    timeouts {}
}

resource "google_compute_address" "nginx-ingress-ip" {
    #address            = "1.2.3.4"
    address_type       = "EXTERNAL"
    name               = "nginx-ingress-ip"
    network_tier       = "PREMIUM"
    region             = "europe-north1"
    depends_on = [
        google_compute_network.sandbox-network
    ]
    timeouts {}
}