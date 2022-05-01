# If ran in Windows, there is a check written with bash that prevents hub to be used.
# Error: External Program Execution Failed
#│
#│   with module.hub-primary.module.gke_hub_registration.data.external.env_override[0],
#│   on .terraform\modules\hub-primary.gke_hub_registration\main.tf line 73, in data "external" "env_override":
#│   73:   program = ["${path.module}/scripts/check_env.sh"]
#│
#│ The data source received an unexpected error while attempting to execute the program.
#│
#│ Program: .terraform/modules/hub-primary.gke_hub_registration/scripts/check_env.sh
#│ Error: fork/exec .terraform/modules/hub-primary.gke_hub_registration/scripts/check_env.sh: %1 is not a valid Win32 application.

module "hub-primary" {
    source           = "terraform-google-modules/kubernetes-engine/google//modules/hub"
    project_id       = var.project_id
    cluster_name     = module.primary-cluster.name
    location         = module.primary-cluster.location
    cluster_endpoint = module.primary-cluster.endpoint
    gke_hub_membership_name = "primary"
    gke_hub_sa_name = "primary"
}

module "hub-secondary" {
    source           = "terraform-google-modules/kubernetes-engine/google//modules/hub"
    project_id       = var.project_id
    cluster_name     = module.secondary-cluster.name
    location         = module.secondary-cluster.location
    cluster_endpoint = module.secondary-cluster.endpoint
    gke_hub_membership_name = "secondary"
    gke_hub_sa_name = "secondary"
}