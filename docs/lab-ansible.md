# Ansible Lab

Now that you've gone through the [guided example](example-ansible.md),
you're ready to put your Ansible knowledge to use.

[Here is the documentation](http://panwansible.readthedocs.io/en/latest/)
for the Ansible modules.

Write Ansible playbooks to configure the following.  As Ansible executes
everything in a playbook and you need to know if you're doing an `add` or an
`update`, it is recommended that you use separate playbook files for
everything.

* Add the following address object:
  
  ![Wordpress Server address object](../pics/wordpress.png)
  
* Add the following security rules:
  
  ![security policy](../pics/security-policy.png)
  
  The following fields are common for all security rules:
  
  * **Rule Type** - universal
  * **Source Addresses** - `"any"`
  * **Source users** - `"any"`
  * **HIP Profiles** - `"any"`
  * **URL categories** - `"any"`
  * **Log at session start** - `False`
  * **Log at session end** - `True`
  
  **Note**:  there are multiple ways to accomplish this.  If you feel like
  challenging yourself, add the rules in an order different from their
  eventual relative positions.


## Solutions

* [Address object](ao-ansible.md)
* [Security rules solution](sp-ansible.md)
