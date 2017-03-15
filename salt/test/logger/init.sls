# uplad logger.sh
logger.sh upload: 
  file.managed:
    - name: /usr/local/sbin/logger.sh
    - source: 
      - salt://test/logger/files/logger.sh
    - user: root
    - group: root
    - mode: '0755'

# install cron if missed
{% if not salt['file.directory_exists' ]('/etc/crontab') %}
install cron:
  pkg.installed:
    - pkgs:
      - cron
{% endif %}

/usr/local/sbin/logger.sh:
  cron.present:
    - user: root
    - minute: 0,30