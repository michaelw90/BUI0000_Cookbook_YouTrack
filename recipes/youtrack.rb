#
# Cookbook Name:: cookbook_youtrack
# Recipe:: youtrack
#

# Decipher the locations
archive_directory = Chef::Config[:file_cache_path]
youtrack_version = node['cookbook_youtrack']['youtrack']['version']
install_root_dir = node['cookbook_youtrack']['youtrack']['install_root_dir']
data_directory = node['cookbook_youtrack']['youtrack']['data_dir']
backup_directory = node['cookbook_youtrack']['youtrack']['backup_dir']
download_url = node['cookbook_youtrack']['youtrack']['download_url']

# Calculate some variables
youtrack_archive_name = "youtrack-#{youtrack_version}.zip"
youtrack_archive_path = "#{archive_directory}/#{youtrack_archive_name}"
install_dir = "#{install_root_dir}/#{youtrack_version}"
current_dir = "#{install_root_dir}/current"

# Install the unzip package
package "unzip" do
  action :install
end

# Create the youtrack root directory
directory install_root_dir do
  recursive true
  action :create
end

# Create the data directory
directory data_directory do
  recursive true
  action :create
end

# Create the backup directory
directory backup_directory do
  recursive true
  action :create
end

# Download the version of youtrack, if we don't already have it
remote_file youtrack_archive_path do
  backup false
  source download_url
  action :create_if_missing
  notifies :run, "bash[extract-youtrack]", :immediately
end

# Run the commands to extract and move youtrack into place.
bash "extract-youtrack" do
  code <<-EOH
    unzip #{youtrack_archive_path} -d #{install_root_dir}
  EOH
  action :nothing
end


# Set the symbolic link to the new installation
link current_dir do
  to install_dir
end