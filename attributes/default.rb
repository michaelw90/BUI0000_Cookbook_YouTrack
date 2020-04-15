default['java']['jdk_version'] = '8'

default['cookbook_youtrack']['youtrack']['version'] = '2019.2.57909'
default['cookbook_youtrack']['youtrack']['install_root_dir'] = '/opt/youtrack'
default['cookbook_youtrack']['youtrack']['data_dir'] = '/root/.YoutrackData'
default['cookbook_youtrack']['youtrack']['backup_dir'] = '/root/.YoutrackBackup'
default['cookbook_youtrack']['youtrack']['download_url'] = 'https://download.jetbrains.com/charisma/youtrack-2019.2.57909.zip'
default['cookbook_youtrack']['youtrack']['memory_options'] = '-Xmx1g'


default['cookbook_youtrack']['systemd'] = false;