# Configuration

*   Log into the GCP console at https://console.cloud.google.com

*   Activate Google Cloud Shell. Use Cloud Shell because the Google Cloud SDK (gcloud) and other tools are included.

*   Perform the initial lab setup

        $ git clone https://github.com/PaloAltoNetworks/terraform_ansible_intro
        $ cd sko19-automation-lab
        $ ./labconfig.sh
        $ export PATH=$HOME/bin:$PATH

*   Set the gcloud config to the correct project (from Qwiklabs portal).

        $ gcloud projects list
        $ gcloud config set project <PROJECT>

* Enable the Compute Engine API

        gcloud services enable compute.googleapis.com

* Download the credentials file for the Compute Engine default service account

        $ gcloud iam service-accounts list
        $ gcloud iam service-accounts keys create gcp_compute_key.json --iam-account <COMPUTE_ENGINE_EMAIL_ADDRESS>

* Configure SSH key pair

        $ ssh-keygen -t rsa -b 1024 -N '' -f ~/.ssh/sko19_ssh_key
        $ chmod 400 ~/.ssh/sko19_ssh_key
        $ gcloud compute config-ssh --ssh-key-file=~/.ssh/sko19_ssh_key
