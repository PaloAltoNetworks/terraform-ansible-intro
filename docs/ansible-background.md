# Ansible Background

## Ansible At a Glance

* Company: [RedHat](https://www.ansible.com/)
* Integration FCS: January 2015
* Configuration: YAML (Yet Another Markup Language)
* [Documentation](http://panwansible.readthedocs.io/en/latest/)
* [GitHub Repo](https://github.com/PaloAltoNetworks/ansible-pan)
* Implementation Language: python


## Configuration Overview

### Playbooks

Though Ansible allows you to execute ad hoc commands against your desired
inventory, the better way to use Ansible is with Ansible playbooks.
Ansible playbooks are a list of configuration operations, or plays, to be
performed.  Ansible playbooks are written in YAML, which you can find out
more about
[here](https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html).
Playbooks are run from top to bottom, which means that if one configuration
depends on another being present, you simply put the dependency higher in the
playbook.  You can even tell Ansible to run another playbook from within the
first playbook by importing it in.

### No Local State

Unlike Terraform, Ansible does not keep a local state of what is configured.

### Modules Are Use Case Focused

Also unlike the Terraform provider, Ansible modules tend to be more use case
focused as opposed to trying to be a single, atomic component controller.  The
[panos_interface](http://panwansible.readthedocs.io/en/latest/modules/panos_interface_module.html)
module is probably the best example of this to date, as it not only creates
interfaces, but can also create zones, place the interface into that zone,
then finally put the interface into a virtual router.  That same workflow in
Terraform would require three separate resources using dependencies.

## Example Ansible Configuration

Here's an example of an Ansible playbook.  We will discuss the various
parts of this below.

```yml
- name: My Ansible Playbook
  hosts: my-fw
  connection: local
  gather_facts: false

  roles:
    - role: PaloAltoNetworks.paloaltonetworks

  tasks:
  - name: Grab auth creds
    include_vars: 'fw_creds.yml'
    no_log: 'yes'

  - name: Add interface management profile
    panos_management_profile:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      name: 'allow ssh'
      ssh: true
      commit: false

  - name: Configure eth1/1 and put it in zone L3-in
    panos_interface:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      if_name: 'ethernet1/1'
      zone_name: 'L3-in'
      commit: false
```

## Terminology

### Hosts

Ansible executes actions against an inventory.  If you’re going to run Ansible
in production, you’ll probably want to use the inventory file to organize your
firewalls and Panoramas into groups to make management easier.  For the
purposes of our lab, however, we just want to run the playbooks against a
single host.  So instead of putting the host in a hosts file, we’re going to
use variables instead.

If you desire, you can read more about Ansible inventory
[here](http://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html).

### Connection

Typically Ansible will ssh to a remote machine and perform commands as the
specified user account.  However, we don't want this for the Palo Alto Networks
Ansible modules, as the modules connect to our API.  Thus this should be set to
"local" as we want Ansible to initiate the connection locally.

### Gather Facts

Ansible facts are just information about remote nodes.  In our case, we aren’t
going to use facts for anything, so we’re disabling them to ensure that our
Ansible invocations are run in a timely manner (this is would probably not be
disabled in production).

If you want to read more about facts, you can find that info
[here](https://docs.ansible.com/ansible/latest/reference_appendices/glossary.html#term-facts).

### Roles

Let’s discuss the "PaloAltoNetworks.paloaltonetworks" role that our playbook
is using.  Ansible comes with various Palo Alto Networks packages when you
`pip install ansible`, but updating these packages takes a lot of time and
effort.  In an effort to get new features to customers sooner, we've made
newer features available as an Ansible galaxy role.  Including this role in
our playbook means that Ansible will use the role’s code (the newest released
code) for the Ansible plays instead of the older code that's merged upstream
with Ansible.

### Tasks

Each playbook contains a list of tasks to perform.  These are executed in
order, one at a time against the inventory.  Each task will have a "name",
and this name is what shows up on the CLI when executing the Ansible playbook.
Besides the name, you will specify the module to execute, and then an
indented list of the values you want to pass in to that module.

Knowing what you know about tasks, let’s take a look at that "include\_vars"
task.  At this point, knowing what the format of tasks is, you can now
identify "include\_vars" as a module invocation (documentation for
"include\_vars" is
[here](https://docs.ansible.com/ansible/latest/modules/include_vars_module.html)).

So what’s that `no_log` part?  This is simply to keep the authentication
credentials safe without compromising the verbosity of our Ansible output.
You can read more about that
[here](https://docs.ansible.com/ansible/latest/reference_appendices/faq.html#how-do-i-keep-secret-data-in-my-playbook)
in the Ansible FAQs.

## Dependencies

As mentioned previously, if you're using Ansible playbooks, then when you
have dependencies, simply place those further up in the playbook.
