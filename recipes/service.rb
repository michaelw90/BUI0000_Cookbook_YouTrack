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
shell_script_path = "#{install_dir}/youtrack/bin/youtrack.sh"

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