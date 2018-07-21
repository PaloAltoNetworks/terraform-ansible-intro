```yml
- name: Address object solution
  hosts: fw
  connection: local
  gather_facts: false

  roles:
    - role: PaloAltoNetworks.paloaltonetworks

  tasks:
  - name: Grab auth creds
    include_vars: 'fw_creds.yml'
    no_log: 'yes'

  - name: "Add address object for wordpress server"
    panos_object:
      ip_address: '{{ "{{" }} ip_address {{ "}} }}'
      username: '{{ "{{" }} username {{ "}} }}'
      password: '{{ "{{" }} password {{ "}} }}'
      operation: 'add'
      addressobject: 'wordpress server'
      address: '10.1.23.45'
      description: 'Internal server'
```
