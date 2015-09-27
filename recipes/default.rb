#
# Cookbook Name:: cookbook_youtrack
# Recipe:: default
#

include_recipe 'java::default'
include_recipe 'cookbook_youtrack::youtrack'
include_recipe 'cookbook_youtrack::service'