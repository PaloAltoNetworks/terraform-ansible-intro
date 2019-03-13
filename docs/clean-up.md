# Clean Up

In this activity you will:

* Destroy the lab deployment

## Destroy the Deployment

When deploying infrastructure in the public cloud it is important to tear it down when it is no longer needed.  Otherwise you will end up paying for services that are no longer needed. We'll need to go back to the deployment directory and use Terraform to destroy the VM-Series instance we deployed at the start of the lab.

Change into the `deployment` directory.

~~~bash
$ cd ../deployment
~~~

Tell Terraform to destroy the contents of its plan files.

~~~bash
$ terraform destroy
~~~

Delete the GCP project with the following `gcloud projects` command.
**Note**: For Qwiklabs deployments the project will be deleted automatically when the lab is exited

~~~bash
$ gcloud projects delete terraform-ansible-lab
~~~


