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

Initiate directory with Terraform:
- terraform init (this downloads all the plugins and modules)
- terraform plan (test that plan is valid - does not create anything yet)
- terraform apply (will create infrastructure)
- To remove all: terraform destroy
