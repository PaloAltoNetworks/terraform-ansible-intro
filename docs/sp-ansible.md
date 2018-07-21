```yml
- name: Security policy solution
  hosts: fw
  connection: local
  gather_facts: false

  roles:
    - role: PaloAltoNetworks.paloaltonetworks

  tasks:
  - name: Grab auth creds
    include_vars: 'fw_creds.yml'
    no_log: 'yes'

  - name: "Add first security rule"
    panos_security_rule:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      operation: 'add'
      rule_name: 'Wordpress Traffic'
      source_zone: ['L3-untrust']
      destination_zone: ['L3-trust']
      destination_ip: ['wordpress server']
      application: ['web-browsing']
      action: 'allow'
      commit: false

  - name: "Add second security rule"
    panos_security_rule:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      operation: 'add'
      rule_name: 'Outbound'
      source_zone: ['L3-trust']
      destination_zone: ['L3-untrust']
      action: 'allow'
      commit: false

  - name: "Add final security rule"
    panos_security_rule:
      ip_address: '{{ ip_address }}'
      username: '{{ username }}'
      password: '{{ password }}'
      operation: 'add'
      rule_name: 'Default Deny'
      action: 'deny'
      commit: false
```
