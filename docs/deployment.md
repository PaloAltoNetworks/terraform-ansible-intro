# Deployment

In this activity you will:

* Define the Terraform plan variables
* Initialize the Terraform providers
* Deploy the VM-Series firewall
* Configure an administrative password

## Define the Terraform plan variables

1. Change into the `deployment` directory.

        $ cd deployment

2. Edit the file containing the Terraform variables.  These variable will be referenced in other Terraform plan files.

        $ vi gcp_variables.tf

3. Replace the default values for `gcp_project_id`, `gcp_region`, `gcp_credentials_file`, and `gcp_ssh_key`.

        variable "gcp_project_id" {
          description = "GCP Project ID"
          type = "string"
          default = ""
        }

        variable "gcp_region" {
          description = "Default to the Montréal, Quebec region"
          type = "string"
          default = "northamerica-northeast1"
        }

        variable "gcp_credentials_file" {
          description = "Path to the GCP credentials JSON file"
          type = "string"
          default = ""
        }

        variable "gcp_ssh_key" {
          description = "Path to the SSH public key file"
          type = "string"
          default = ""
        }

4. Save the file and exit the text editor.

## Initialize the Terraform providers
1. Type the following command to initialize any Terraform providers specified in the plan files.

        $ terraform init

## Begin the Terraform deployment
1. Type the following command to perform a dry-run of the Terraform plan and gather its state data.

        $ terraform plan

2. Type the following command to execute the Terraform plan.  You can append `--auto-approve` to the command in order to avoid the confirmation step.

        $ terraform apply

## Set the firewall administrator password
1. Use the `gcloud compute` command to get the hostname of the VM-Series firewall instance.

        $ gcloud compute instances list

2. SSH into the firewall using the hostname of the instance.

        $ ssh admin@<HOSTNAME>

3. Set the administrative password for the VM-Series firewall.

        admin> configure
        admin# set mgt-config users admin password
        admin# set password
        admin# commit
        admin# exit
        admin> exit

4. You are now ready to begin the Terraform portion of the lab.
