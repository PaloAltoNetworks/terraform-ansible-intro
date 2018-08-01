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

Replace the default value for the variable `gcp_project_id` with the GCP Project ID displayed in the Qwiklabs main page.  The `gcp_region`, `gcp_credentials_file`, and `gcp_ssh_key` variables have been pre-populated.

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
  description = "Full path to the JSON credentials file"
  type = "string"
  default = "../gcp_compute_key.json"
}

variable "gcp_ssh_key" {
  description = "Full path to the SSH public key file"
  type = "string"
  default = "../../.ssh/sko19_ssh_key.pub"
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

Type the following command to execute the Terraform plan.  You can append `--auto-approve` to the command in order to avoid the confirmation step.  This will deploy the VM-Series instance in GCP.  This will take a few moments to complete.

```bash
$ terraform apply
```
Copy and paste the output fields (in green) into a note or document on your laptop.  You will need this information later.

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
$ ssh admin@<INSTANCE>.<ZONE>.<PROJECT>
```

---
**NOTE:** If you receive a `Connection refused` response or are prompted for a password the VM-Series instance has not fully booted yet.  Hit **Control-C** and wait few moments before trying again.  Feel free to read the [Terraform Bankground](terraform-background) section to learn more about Terraform while you're waiting.

---

Once successfully logged in and presented with a CLI prompt you must set the administrative password for the VM-Series firewall.

```html
admin@PA-VM> configure
admin@PA-VM# set mgt-config users admin password
admin@PA-VM# commit
admin@PA-VM# exit
admin@PA-VM> exit
```

Launch a separate web browser tab and log into the VM-Series web user interface using the external IP address of the VM-Series instance.

You are now ready to begin the Terraform portion of the lab.
