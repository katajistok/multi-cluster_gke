# Multi-Cluster GKE

Testing multi-cluster capabilities on this repository.

Terraform files should work on Windows machine using PowerShell in admin mode.

As a pre-requisities, there are:
- Existing Google Cloud project
- Service account created and credentials stored as a json -file. This is used on main.tf -file.
- Git installed (I use: https://gitforwindows.org/)
- Google SDK installed (https://cloud.google.com/sdk/docs/install)
- Authentication to GCP performed from PowerShell (gcloud auth application-default login)

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
