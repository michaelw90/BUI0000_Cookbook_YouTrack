#
# Cookbook Name:: cookbook_youtrack
# Recipe:: nginx
#
# Install Nginx from source to support custom Nginx modules in future.
#

# Get the details
hostname = node['cookbook_youtrack']['youtrack']['address']

# Set the initialisation style for nginx
node.set['nginx']['init_style'] = "init"

# Install nginx from source
include_recipe "nginx::source"

template( File.join(node["nginx"]["dir"], "sites-available", 'youtrack') ) do
  source    'nginx_vhost.conf.erb'
  mode      '0644'
  owner     'root'
  group     'root'
  variables(
      :log_dir        => node["nginx"]["log_dir"],
      :appname        => 'youtrack',
      :hostname       => hostname
  )
  notifies :enable, 'service[nginx]'
  notifies :start, 'service[nginx]'
end

nginx_site 'youtrack' do
  notifies :reload, 'service[nginx]'
end