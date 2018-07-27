# Deployment

*   Set the Terraform deployment variables

        $ cd deployment
        $ vim gcp_variables.tf

*   Initialize the Terraform providers

        $ terraform init

*   Begin the Terraform deployment

        $ terraform plan
        $ terraform apply

*   Set the firewall administrator password

        admin> ssh admin@<ADDRESS>
        admin\# configure
        admin\# set mgt-config users admin password
        admin\# set password
        admin\# commit
        admin\# exit
        admin> exit

