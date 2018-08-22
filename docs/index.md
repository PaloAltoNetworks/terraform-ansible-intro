![SKO2019 Title](img/sko2019-logo.png)

## Introduction

Welcome to the Terraform & Ansible Introduction lab!

In this lab we will deploy a VM-Series firewall in [Google Cloud Platform](https://cloud.google.com) (GCP) using Terraform.  Once deployed, we will then use [Terraform](https://www.terraform.io) and [Ansible](https://www.ansible.com) to manage the configuration of the firewall.  This will include hands-on definition of Terraform plans and Ansible playbooks while exploring the functionality of the Palo Alto Networks Ansible modules and Terraform provider.

The following are NOT goals of this lab:

* __Show a realistic deployment of the firewall:__ More realistic deployment would only complicate the provisioning configuration. If you want to see a more realistic deployment of the firewall in GCP, then please refer to the links at the end of this document for examples.

* __Teach Google Cloud Platform (GCP) functionality:__ The choice to use GCP for this lab was intended to provide exposure to GCP and its command line utilities.  However, a comprehensive overview of GCP is beyond the scope of this lab.  Many of the concept we'll briefly cover are similar to other public cloud providers.

## Requirements

* A laptop with Internet connectivity
* A standards-compliant web browser (Google Chrome recommended)
* Understanding of Linux operating system basics
* Proficiency with a Linux text editor (e.g., vim, nano, or emacs)

## About This Lab

* __Qwiklabs:__ This lab is launched using Qwiklabs, which is an online learning environment that provides access to the actual environment you want to learn about, not a simulation or demo environment. Qwiklabs will establish a temporary account in Google Cloud Platform and create a new GCP project to use.  However, this lab may also be used outside of Qwiklabs if you have a have a [GCP account](https://cloud.google.com/free).
* __Google Cloud SDK:__ The initial configuration of the lab environment utilizes the Google Cloud SDK command line interface to perform tasks such as enabling APIs and establishing credentials.  These tasks could just as easily be accomplished using the GCP web console.  However, familiarity with the CLI commands is useful and presents opportunities for further scripting and automation.
