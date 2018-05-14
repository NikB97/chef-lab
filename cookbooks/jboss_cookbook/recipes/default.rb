#
# Cookbook:: jboss_cookbook
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# java
include_recipe 'java'

# creating user
user 'jboss' do
  comment 'jboss user'
  shell '/bin/bash'
end

# downloading jboss.zip
remote_file '/home/vagrant/jboss.zip' do
  source 'https://kent.dl.sourceforge.net/project/jboss/JBoss/JBoss-5.1.0.GA/jboss-5.1.0.GA.zip'
  show_progress true
end

# installing unzip
package 'unzip'

# unziping archive
bash 'unarchive' do
  code <<-EOH
    mkdir -p /opt/jboss/
    unzip /home/vagrant/jboss.zip -d /opt/
    cp -r /opt/jboss-5.1.0.GA/* /opt/jboss/
    chown -R jboss:jboss /opt/jboss
    EOH
end

# including jboss service
template '/etc/systemd/system/jboss.service' do
  source 'jboss.service.erb'
end

# including server.xml from templates
data = data_bag_item('port','jb_port')
template '/opt/jboss/server/default/deploy/jbossweb.sar/server.xml' do
  source "server.xml.erb"
  owner 'jboss'
  group 'jboss'
  variables(jbport: data['port'])
  mode 0644
end


# deploying sample.war
remote_file '/opt/jboss/server/default/deploy/sample.war' do
#  source 'https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war'
  source "#{node['war_repo']}"
  show_progress true
end

# daemon-reload
bash 'daemon-reload' do
  code <<-EOH
    sudo systemctl daemon-reload
    EOH
end

# enabling and starting jboss
service 'jboss' do
  action [:enable, :start]
end
