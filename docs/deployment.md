# Deployment

In this activity you will:

* Define the Terraform plan variables
* Initialize the Terraform providers
* Deploy the VM-Series firewall
* Update the SSH configs
* Set the firewall administrative password

## Define the Terraform plan variables

Change into the `deployment` directory.

```bash
$ cd deployment
```

Edit the file containing the Terraform variables.  These variable will be referenced in other Terraform plan files.

```bash
$ vi gcp_variables.tf
```

Replace the default values for variables `gcp_project_id`, `gcp_region`, `gcp_credentials_file`, and `gcp_ssh_key`.

```yml
variable "gcp_project_id" {
  description = "GCP Project ID"
  type = "string"
  default = ""
}

variable "gcp_region" {
  description = "Montréal, Quebec GCP region"
  type = "string"
  default = "northamerica-northeast1"
}

variable "gcp_credentials_file" {
  description = "Full file path to the JSON credentials file"
  type = "string"
  default = ""
}

variable "gcp_ssh_key" {
  description = "Full file path to the SSH public key file"
  type = "string"
  default = ""
}
```

Save the file and exit the text editor.

## Initialize the Terraform providers
Type the following command to initialize any Terraform providers specified in the plan files.

```bash
$ terraform init
```

## Deploy the VM-Series firewall
Type the following command to perform a dry-run of the Terraform plan and gather its state data.

```bash
$ terraform plan
```

Type the following command to execute the Terraform plan.  You can append `--auto-approve` to the command in order to avoid the confirmation step.

```bash
$ terraform apply
```

## Update the SSK config
Use the following `gcloud compute` command to override the default GCP key management process and utilize our SSH key.

```bash
$ gcloud compute config-ssh --ssh-key-file=~/.ssh/sko19_ssh_key
```

## Set the firewall administrator password
Use the `gcloud compute` command to get the hostname of the VM-Series firewall instance.

```bash
$ gcloud compute instances list
```

SSH into the firewall using the fully qualified hostname of the instance.  You may need to wait a few moments for the firewall to finish booting up.

```bash
$ ssh admin@<INSTANCE>.<ZONE>.<REGION>
```

Set the administrative password for the VM-Series firewall.

```html
admin> configure
admin# set mgt-config users admin password
admin# set password
admin# commit
admin# exit
admin> exit
```

4. You are now ready to begin the Terraform portion of the lab.
