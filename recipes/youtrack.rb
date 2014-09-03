#
# Cookbook Name:: cookbook_youtrack
# Recipe:: youtrack
#

# Decipher the locations
youtrack_version = node["cookbook_youtrack"]["youtrack"]["version"]
install_dir = node['cookbook_youtrack']['youtrack']['install_dir']
memory_options = node['cookbook_youtrack']['youtrack']['memory_options']
apps_directory = node['appbox']['apps_dir']
apps_user = node['appbox']['apps_user']
youtrack_jar_name = "youtrack-#{youtrack_version}.jar"
youtrack_download_url = "#{node['cookbook_youtrack']['youtrack']['download_url']}#{youtrack_jar_name}"
jar_path = "#{install_dir}/#{youtrack_jar_name}"
shell_script_path = "#{install_dir}/youtrack.sh"

# Create the youtrack directory
directory install_dir do
  recursive true
  action :create
end

# Download youtrack into place
remote_file jar_path do
  backup false
  source youtrack_download_url
  action :create_if_missing
end

# Create the service template and notify the start of the service
template 'youtrack.sh' do
  path shell_script_path
  source 'youtrack.sh.erb'
  variables(
      :install_dir => install_dir,
      :memory_options => memory_options
  )
  owner apps_user
  mode '0755'
end