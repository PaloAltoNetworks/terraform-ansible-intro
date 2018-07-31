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
Download the lab repository to your home directory.

```bash
$ git clone https://github.com/PaloAltoNetworks/terraform-ansible-intro
```

Change into the lab directoryu and run the lab configuration script.  This will install the Terraform binary and the Ansible package.

```bash
$ cd terraform-ansible-intro
$ ./setup
```

Test to ensure the Terraform and Ansible binaries are properly installed.  Both executables should be located in the `/usr/local/bin` directory.

```bash
$ terraform --version
$ ansible --version
```

## Verify the Google Cloud SDK configuration
Use the following `gcloud config` command to ensure you are using the Qwiklabs account and project identifier.

```bash
$ gcloud config list
```

Confirm that the `account` and `project` are the same as those provided by Qwiklabs.

Use the following command to change the account (if needed).

```bash
$ gcloud auth login <QWIKLABS_USERNAME>
```

Use the following command to change the project (if needed).

```bash
$ gcloud config set project <QWIKLABS_PROJECT>
```

## Enable the Compute Engine API
Use the following `gcloud services` command to enable the Compute Engine API.  This API will be used by Terraform to deploy the VM-Series instance.

```bash
$ gcloud services enable compute.googleapis.com
```

## Configure API credentials
Use the following `gcloud iam` command to list the default service accounts.

```bash
$ gcloud iam service-accounts list
```

Use the following `gcloud iam` command to download the credentials for the Compute Engine default service account using it associated email address.

```bash
$ gcloud iam service-accounts keys create gcp_compute_key.json --iam-account <EMAIL_ADDRESS>
```

Verify the JSON credentials file was successfully created.

```bash
cat gcp_compute_key.json
```

## Configure SSH credentials
Create an SSH key with an empty passphrase and save it in the `~/.ssh` directory.

```bash
$ ssh-keygen -t rsa -b 1024 -N '' -f ~/.ssh/sko19_ssh_key
```

Ensure the file permissions for the SSH key are secure.

```bash
$ chmod 400 ~/.ssh/sko19_ssh_key
```

---
**NOTE:** GCP has the ability to manage all of its own SSH keys and propagate them automatically to projects and instances.  However, the VM-Series is only able to make use of a single SSH key.  Rather than leverage GCP's SSH key management process, we've created our own SSH key and configured the Compute Engine to use our key exclusively.  When we deploy the VM-Series in the next activity we'll instruct the instance to also use the SSH key we've created.

---
