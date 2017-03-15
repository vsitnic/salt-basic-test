# get users from grains, create them and add same RSA key

{% for usr in salt['grains.get']('ssh_users', []) %}
{{ usr }}:
  group:
    - present
  user:
    - present
    - shell: /bin/bash
    - home: /home/{{ usr }}
    - gid_from_name: True
    - require:
      - group: {{ usr }}

{{ usr }}-rsa:
  ssh_auth:
    - present
    - user: {{ usr }}
    - enc: rsa
    - source: salt://test/users/templates/authorized_keys.jinja
    - show_changes: True
    - require:
      - user: {{ usr }}

{% endfor %}


