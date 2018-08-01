# Clean Up

In this activity you will:

* Destroy the deployment

## Destroy the Deployment

When deploying infrastructure in the public cloud it is important to tear it down when it is no longer needed.  Otherwise you will end up paying for services that are no longer needed.

Change into the `deployment` directory.

~~~bash
$ cd ../deployment
~~~

Tell Terraform to destroy the contents of its plan files.

~~~bash
$ terraform destroy
~~~

---
**NOTE:** Qwiklabs would normally handle this for you once the lab is completed but the process is illustrated here as a helpful reminder.

---


