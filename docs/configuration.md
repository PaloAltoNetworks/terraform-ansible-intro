# Configuration

In this activity you will:

* Install Terraform and Ansible
* Configure the Google Cloud SDK
* Enable the Compute Engine API
* Configure API credentials
* Configure SSH credentials

---
**NOTE:**  All of the commands listed within this activity should be executed within the Google Cloud Shell - __not on your laptop__.

---

## Install Terraform and Ansible
1. Download the lab repository to your home directory.

        $ git clone https://github.com/PaloAltoNetworks/terraform-ansible-intro

2. Change into the lab directoryu and run the lab configuration script.  This will install the Terraform binary and the Ansible package.

        $ cd terraform-ansible-intro
        $ ./setup

3. Test to ensure the Terraform and Ansible binaries are properly installed.  Both executables should be located in the `/usr/local/bin` directory.

        $ terraform --version
        $ ansible --version

## Configure the Google Cloud SDK
1. Use the following `gcloud config` command to select the Qwiklabs project identifier.  If you had multiple projects this would ensure subsequent `gcloud` commands are scoped to this specific project.

        $ gcloud config set project <PROJECT>

2. Confirm the project selection was successful.

        $ gcloud config get-value project

## Enable the Compute Engine API
1. Use the following `gcloud services` command to enable the Compute Engine API.  This API will be used by Terraform to deploy the VM-Series instance.

        $ gcloud services enable compute.googleapis.com

## Configure API credentials
1. Use the following `gcloud iam` command to list the default service accounts.

        $ gcloud iam service-accounts list

2. Locate the Compute Engine default service account and its email address.
3. Use the following `gcloud iam` command to download the credentials for the Compute Engine default service account.

        $ gcloud iam service-accounts keys create gcp_compute_key.json --iam-account <EMAIL_ADDRESS>

## Configure SSH credentials
1. Create an SSH key with an empty passphrase and save it in the `~/.ssh` directory.

        $ ssh-keygen -t rsa -b 1024 -N '' -f ~/.ssh/sko19_ssh_key

2. Ensure the file permissions for the SSH key are secure.

        $ chmod 400 ~/.ssh/sko19_ssh_key

3. Use the following `gcloud compute` command to override the default GCP key management process and utilize our SSH key.

        $ gcloud compute config-ssh --ssh-key-file=~/.ssh/sko19_ssh_key

---
**NOTE:** GCP has the ability to manage all of its own SSH keys and propagate them automatically to projects and instances.  However, the VM-Series is only able to make use of a single SSH key.  Rather than leverage GCP's SSH key management process, we've created our own SSH key and configured the Compute Engine to use our key exclusively.  When we deploy the VM-Series in the next activity we'll instruct the instance to also use the SSH key we've created.

---
