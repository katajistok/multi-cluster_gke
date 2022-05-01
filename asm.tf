# If ran in Windows, there is a check that prevents asm to be used.
#│ Error: External Program Execution Failed
#│
#│   with module.asm-secondary.module.cpr.module.gcloud_kubectl.data.external.env_override[0],
#│   on .terraform\modules\asm-secondary.cpr\main.tf line 73, in data "external" "env_override":
#│   73:   program = ["${path.module}/scripts/check_env.sh"]
#│
#│ The data source received an unexpected error while attempting to execute the program.
#│
#│ Program: .terraform/modules/asm-secondary.cpr/scripts/check_env.sh
#│ Error: fork/exec .terraform/modules/asm-secondary.cpr/scripts/check_env.sh: %1 is not a valid Win32 application.

module "asm-primary" {
  source                = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version               = "20.0.0"
  project_id            = var.project_id
  cluster_name          = module.primary-cluster.name
  cluster_location      = module.primary-cluster.region  
}

module "asm-secondary" {
  source                = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version               = "20.0.0"
  project_id            = var.project_id
  cluster_name          = module.secondary-cluster.name
  cluster_location      = module.secondary-cluster.region      
}