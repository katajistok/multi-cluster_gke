# Multi-Cluster GKE

Testing multi-cluster capabilities on this repository.

Terraform files do not work on Windows because of asm.tf and hub.tf modules which use Linux bash script to check status of deployment.

As a pre-requisities, there are:
- Existing Google Cloud project
- GCP Project number (is stored as tf vars)
- Service account created and credentials stored as a json -file. This is used on main.tf -file.
- Git installed (Linux, probably already there. For Windows I use: https://gitforwindows.org/)
- Google SDK installed (https://cloud.google.com/sdk/docs/install)
- Authenticated to GCP: gcloud auth application-default login

Service account privileges:
- roles/compute.viewer
- roles/compute.securityAdmin (only required if add_cluster_firewall_rules is set to true)
- roles/container.clusterAdmin
- roles/container.developer
- roles/iam.serviceAccountAdmin
- roles/iam.serviceAccountUser
- roles/resourcemanager.projectIamAdmin (only required if service_account is set to create)

Terraform deployment:
- terraform init (this downloads all the plugins and modules)
- terraform plan (test that plan is valid - does not create anything yet)
- terraform apply (will create infrastructure)
- To remove all: terraform destroy

Known issues:
- Does not work with Windows
- ASM module throws namespace errors in some point
- Deletion of the next GCP resources does not succeed when using "terraform destroy":
-  - subnets
-  - firewall rules

For further development:
- Activate some Anthos features: Ingress, x...
- test-app (Nginx) should show page where server geographic location would be easier to see --> nice demo
- test-app: removal script (if resources won't be removed before 'terraform destroy' some of the network resources will hang)
