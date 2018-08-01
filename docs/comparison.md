# Comparing Terraform and Ansible

At this point, you've now used both Ansible and Terraform to configure a
Palo Alto Networks firewall.  Though you've used these two tools to deploy
the same configuration, they differ in some important ways.  Let's discuss
some of those differences now.

## Reputation

Both tools have a certain reputation associated with them.  Terraform is known
more for its power in deployment, while Ansible is known more for its
flexibility in configuration.  Both products can do both jobs just fine.

Regardless of their reputations, the most important part is that Palo Alto Networks
has integrations with both, and either way will get the job done.  It's
just a matter of preference.

## Idempotence

Both Terraform and Ansible support [*idempotent*](https://en.wikipedia.org/wiki/Idempotence)
operations.  Saying that an operation is idempotent means that applying it
multiple times will not change the result.  This is important for automation
tools because they can be run to change configuration **and** also to verify
that the configuration actually matches what you want.  You can run
`terraform apply` continuously for hours, and if your configuration matches
what is defined in the plan, it won't actually change anything.

However, the Palo Alto Networks Ansible modules do not currently support
idempotent operation.  Most of the modules have an **operation** field which
can be *add*, *update* or *delete*.  Running the same playbook over again will
cause a failure, because you can't add objects over top of themselves, or
delete ones that don't exist.  Supporting idempotent operations will be added
to these modules in the future.

## Commits

As you've probably noticed, a lot of the Ansible modules allow you to commit
directly from them.  There is also a dedicated Ansible module that just does
commits, containing support for both the firewall and Panorama.

So how do you perform commits with Terraform?  Currently, there is no support
for commits inside the Terraform ecosystem, so they have to be handled
externally.  Lack of finalizers are
[a known shortcoming](https://github.com/hashicorp/terraform/issues/6258)
for Terraform and, once it is addressed, support for it can be added to the
provider.  In the mean time, we provide
[a golang script](https://www.terraform.io/docs/providers/panos/index.html#commits)
you can use to fill the gap.

## Operational Commands

Ansible currently has a *panos_op* module allows users to run arbitrary
operational commands.  An operational command could be something that just
shows some part of the configuration, but it can also change configuration.
Since Ansible doesn't store state, it doesn't care what the invocation of
the *panos_op* module results in.

This is a different story in Terraform.  The basic flow of Terraform is that
there is a read operation that determines if a create, update, or delete needs
to take place.  But operational commands as a whole don't fit as neatly into
this paradigm.  What if the operational command is just a read?  What if the
operational command makes a configuration change, and should only be executed
once?  This uncertainty is why support for operational commands in Terraform
is not currently in place.

## Facts / Data Sources

Terraform may not have support for arbitrary operational commands, but it does
have a data source right now that you can retrieve specific parts of
`show system info` from the firewall or Panorama and then use that in your
plan file.

This same thing is called "facts" in Ansible.  Some of our Ansible modules have
support for an additional operation, `find`, that acts in some ways like this,
but support for this is still being investigated or developed.

## Further Reading

* Terraform
    * [Terraform Documentation](https://www.terraform.io/docs/index.html)

    * [Terraform panos Provider](https://www.terraform.io/docs/providers/panos/index.html)

    * [Terraform: Up & Running](https://www.terraformupandrunning.com)

* Ansible
    * [Ansible Docs](https://docs.ansible.com)

    * [ansible-pan](https://panwansible.readthedocs.io/en/latest/index.html)

    * [Ansible: Up & Running](http://www.ansiblebook.com)
