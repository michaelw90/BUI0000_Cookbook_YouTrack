#
# Cookbook Name:: cookbook_youtrack
# Recipe:: service
#

# Decipher the locations
archive_directory = Chef::Config[:file_cache_path]
youtrack_version = node['cookbook_youtrack']['youtrack']['version']
install_root_dir = node['cookbook_youtrack']['youtrack']['install_root_dir']
data_directory = node['cookbook_youtrack']['youtrack']['data_dir']
backup_directory = node['cookbook_youtrack']['youtrack']['backup_dir']
memory_options = node['cookbook_youtrack']['youtrack']['memory_options']

# Calculate some variables
install_dir = "#{install_root_dir}/#{youtrack_version}"
shell_script_path = "#{install_dir}/bin/youtrack.sh"

if node[:teamcity_build_agent][:systemd]
  systemd_unit "youtrack.service" do
    enabled true
    active true
    content "[Unit]\nDescription=YouTrack\nAfter=network.target\n\n[Service]\nType=forking\nPIDFile=" + install_dir + "/logs/youtrack.pid\nExecStart=" + shell_script_path + " start\nExecStop=" + shell_script_path + " stop\n\nRestart=always\n[Install]\nWantedBy=multi-user.target"
    action [:create, :enable, :start]
  end
else
  # Create youtrack Service
  template '/etc/init/youtrack.conf' do
    source 'youtrack.conf.erb'
    variables(
      :memory_options => memory_options,
      :shell_script_path => shell_script_path
    )
    notifies :start, 'service[youtrack]', :immediately
  end

  # Start youtrack Service
  service "youtrack" do
    provider Chef::Provider::Service::Upstart
    action :restart
  end
end