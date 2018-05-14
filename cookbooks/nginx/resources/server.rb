# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :nginx_server
property :role, String, default: 'jboss_role'
property :delete_proxy, String, default: '1.2.3.4'
default_action :attach

# including proxy to jboss
action :attach do
  result = ""
  search(:node, 'role:jboss_role').each do |node|
    p node['ipaddress']
    result += "server #{node[:network][:interfaces][:enp0s8][:addresses].detect{|k,v| v[:family] == 'inet' }.first}:8095; "
  end

# setting up ip addresses in template
  ip = node[:network][:interfaces][:enp0s8][:addresses].detect{|k,v| v[:family] == 'inet' }.first
  template '/etc/nginx/nginx.conf' do
    source "nginx.conf.erb"
    variables(
      jboss_list: result,
      nginx_server: ip
    )
  end

  service 'nginx' do
    action [:restart]
  end
end

# deleting proxy to jboss
action :detach do
  bash 'delete_proxy' do
    code <<-EOH
      sed -i '/#{delete_proxy}/d' /etc/nginx/nginx.conf
      EOH
  end

  service 'nginx' do
    action [:restart]
  end
end
