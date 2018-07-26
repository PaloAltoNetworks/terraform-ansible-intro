# Comparing Terraform and Ansible

At this point, you've now used both Ansible and Terraform to configure a
Palo Alto Networks firewall.  Though you've used these two tools to deploy
the same configuration, they differ in some important ways.  Let's discuss
some of those differences now.

## Reputation

Both tools have a certain reputation associated with them.  Terraform is known
more for its power in deployment, while Ansible is known more for its
flexibility in configuration.  Both products can do both jobs just fine.

Besides their reputations, the most important part is that Palo Alto Networks
has integrations with both, and either way will get the job done.  It's
just a matter of preference.

## Idempotence

The concept of idempotent operations (in a web server context) means that
the success of the request is not linked to how many times it is
executed.  For Terraform, you can run `terraform apply` for hours, and if
there isn't anything to do, then there isn't anything to do.

For the Ansible modules, however, this is not currently the case.  Most of
the Palo Alto Networks Ansible modules have an "operation" field
whose values (amongst other possibilities) can be "add", "update", or
"delete".  There is no way to say, "just make sure X is there and
configured like Y."

Having said all this, adding idempotent behavior to the Ansible modules will
get added to the Palo Alto Networks modules in the future.

## Commits

One big topic that we’ve not touched on yet is commits.

As you've probably noticed, a lot of the Ansible modules allow you to commit
directly from them.  There is also a dedicated Ansible module that just does
commits, containing support for both the firewall and Panorama.  So what is
the Terraform story around commits?

Currently there is no support for commits inside the Terraform ecosystem;
they have to be handled outside of Terraform.  Lack of finalizers are
[a known shortcoming](https://github.com/hashicorp/terraform/issues/6258)
for Terraform and, once it is addressed, support for it can be added to the
provider.  In the mean time, if you’re using CLI Terraform, then we provide
[a golang script](https://www.terraform.io/docs/providers/panos/index.html#commits)
that you can use to fill the gap.

## Operational Commands

Ansible currently has a *panos\_op* module allows users to run arbitrary
operational commands.  An operational command could be something that just
shows some part of the configuration, but it can also change configuration.
Since Ansible doesn't store state, it doesn't care what the invocation of
the *panos\_op* module results in.

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
