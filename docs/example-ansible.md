# Ansible Guided Example

In this guided example, we're going to walk through creating basic networking
for subsequent configuration to make use of.

Create the following:

* ethernet1/1 as DHCP in a zone named "L3-trust"
* ethernet1/2 as DHCP in a zone named "L3-untrust"


## Basic Config

First off, you'll want to install the Ansible Galaxy role.  Perform the
following to install the Ansible Galaxy role:

```bash
$ ansible-galaxy install PaloAltoNetworks.paloaltonetworks
```

Next, find or create an empty directory, making it the current working
directory, as we'll use it for all of our Ansible playbooks.

Open a text editor (e.g. - `vi`, `emacs`, `nano`, `notepad.exe`) and let's
start with defining our Ansible inventory file.  In production, inventory files
would be saved to `/etc/ansible/hosts`, so you can either open that file or
make a file in the local directory to act as your inventory file.  **Note**:
if you choose the later option, you will need to perform all `ansible-playbook`
commands from here on out with `-i <filename>`.  See the inventory documentation
[here](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html)
for more information on Ansible inventory.

In either case, write the following to your hosts file, replacing the IP
address with the actual IP address of your PAN-OS server:

```yml
[fw]
127.0.0.1
```

Now that we have our hosts setup, we need to configure the auth credentials
of the firewall.  Use your text editor to create a file named `fw_creds.yml`
and enter the IP address and authentication credentials of your PAN-OS
firewall:

```yml
ip_address: '127.0.0.1'
username: 'admin'
password: 'admin'
```

With all that out of the way, we're ready to configure the header of our first
Ansible playbook.  If you refer back to the [example Ansible
configuration](https://paloaltonetworks.github.io/terraform-ansible-intro/docs/ansible-basics.html#example-ansible-configuration)
we covered in the previous section, you basically want to copy everything
from the beginning of the file up to and including the `include_vars`
task.  The only change is that we're calling our inventory `fw` instead of
`my-fw`.  So your Ansible playbook should look like this so far:

```yml
- name: My Ansible Playbook
  hosts: fw
  connection: local
  gather_facts: false

  roles:
    - role: PaloAltoNetworks.paloaltonetworks

  tasks:
  - name: Grab auth creds
    include_vars: 'fw_creds.yml'
    no_log: 'yes'
```

## Ethernet Interfaces

Now we're ready to create the ethernet interfaces.  Here's pictures of the
ethernet1/1 interface as well as its zone:

![ethernet1/1](../pics/eth1.png)

![L3-trust zone](../pics/l3-trust.png)

[Here is the
documentation](http://panwansible.readthedocs.io/en/latest/modules/panos_interface_module.html)
for ethernet interfaces.  Take a few minutes to glance over this page and the
parameters it accepts.

So, after looking at the parameters that it supports, did you see that it has
a parameter for the zone built in already?  This means that this single module
is kind of like a one-stop shop for performing the entire config for this
interface.

So, let's start with the basics:  we need to tell Ansible to use
the `panos_interface` module, and we'll use the name "Configure eth1/1:

```yml
  - name: "Configure eth1/1"
    panos_interface:
```

Next up, let's include the authentication credentials the `include_vars` task
imported for us to set the required authentication credential parameters:

```yml
  - name: "Configure eth1/1"
    panos_interface:
      ip_address: '&#123;&#123; ip_address &#125;&#125;'
      username: '{{ username }}'
      password: '{{ password }}'
```

Next, we want to configure ethernet1/1, so let's specify that next:

```yml
  - name: "Configure eth1/1"
    panos_interface:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      if_name: 'ethernet1/1'
```

We need to configure it as a layer3 interface, which is the `mode` parameter,
however that is the default, so we can omit that.  Additionally, we want to
configure it as a DHCP interface, but that is also the default, so we can omit
that, too.  The same is true for the `operation` parameter, as we want to add
this interface.  However, we do want to create the DHCP default route, and that
default is `False`, so let's enable that:

```yml
  - name: "Configure eth1/1"
    panos_interface:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      if_name: 'ethernet1/1'
      create_default_route: true
```

Finally, there are only two more things we need to configure:  the
`zone_name` and the `commit` parameters.  The documentation says that if the
zone doesn't already exist that it's created automatically.  Additionally,
we're going to disable the commit in this operation because it makes more sense
to commit at the end of the full playbook instead of at each individual step,
so let's add these two in to our config:

```yml
  - name: "Configure eth1/1"
    panos_interface:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      if_name: 'ethernet1/1'
      create_default_route: true
      zone_name: 'L3-trust'
      commit: False
```

Now we just need to do the same thing for ethernet1/2 and its zone:

![ethernet1/2](../pics/eth2.png)

![L3-untrust zone](../pics/l3-untrust.png)

Just copy/paste the above config and make the necessary changes:

* ethernet1/2 instead of ethernet1/1
* L3-untrust instead of L3-trust
* don't create the default route

When you're done, it should look something like this:

```yml
  - name: "Configure eth1/2"
    panos_interface:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      if_name: 'ethernet1/2'
      zone_name: 'L3-untrust'
      commit: False
```

## Putting It All Together

Your final playbook should look something like this:

```yml
- name: My Ansible Playbook
  hosts: fw
  connection: local
  gather_facts: false

  roles:
    - role: PaloAltoNetworks.paloaltonetworks

  tasks:
  - name: Grab auth creds
    include_vars: 'fw_creds.yml'
    no_log: 'yes'

  - name: "Configure eth1/1"
    panos_interface:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      if_name: 'ethernet1/1'
      create_default_route: true
      zone_name: 'L3-trust'
      commit: False

  - name: "Configure eth1/2"
    panos_interface:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      if_name: 'ethernet1/2'
      zone_name: 'L3-untrust'
      commit: False
```

If the above is saved as `eth.yml`, then you would execute the playbook like
so:

```bash
$ ansible-playbook eth.yml
```

Keep in mind that if you did not install the inventory globally, then you'll
also need to tell Ansible where your inventory file is as discussed above.

You shouldn't get any errors from this, but if you do, most times indentation
is the problem.  Once you fix any errors that may be present, the firewall
config should now reflect your desired config.
