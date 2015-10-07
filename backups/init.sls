---
- hosts: webservers
  sudo: yes
  tasks:
    - name: Install backups software
      copy: src=../private/backups/dropbox-uploader dest=/usr/local/dropbox-uploader

    - name: Install backups software credentials
      copy: src=../private/backups/.dropbox_tokens dest=~/.dropbox_tokens

    - name: Install backups scripts
      copy: src=../private/backups/{{ ansible_fqdn }} dest=/usr/local/auto-backups

    - name: Install backups cron entry
      cron: name="Automatic backups to Dropbox" minute="0" hour="6" job="bash /usr/local/auto-backups | logger"
