#
# Cookbook Name:: cookbook_youtrack
# Recipe:: service
#

# Retrieve the useful variables for the recipe
apps_directory = node['appbox']['apps_dir']
install_dir = node['cookbook_youtrack']['youtrack']['install_dir']
shell_script_path = "#{install_dir}/youtrack.sh"

# Create the service
service 'youtrack' do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action :nothing
end

# Create the service template and notify the start of the service
template 'youtrack' do
  path '/etc/init.d/youtrack'
  source 'youtrack.erb'
  variables(
      :home_directory => apps_directory,
      :shell_script_path => shell_script_path
  )
  owner 'root'
  group 'root'
  mode '0755'
  notifies :enable, 'service[youtrack]'
  notifies :restart, 'service[youtrack]'
end