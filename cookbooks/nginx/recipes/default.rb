#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
end

# adding proxy to jboss server
nginx_server 'proxy_to_jboss' do
  action [:attach]
end

=begin
nginx_server 'proxy_delete' do
  delete_proxy '2.2.2.2'
  action [:detach]
end
=end
