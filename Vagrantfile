Vagrant.configure("2") do |config|

config.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"

# SERVER
config.vm.define "chef_server" do |chef_server|
  chef_server.vm.hostname = "chef-server"
	chef_server.vm.network "private_network", ip: "192.168.56.20"

chef_server.vm.provider "virtualbox" do |vb|
	vb.memory = "2048"

end
end


# NODE 1
config.vm.define "chef_node" do |chef_node|
  chef_node.vm.hostname = "chef-node-app"
	chef_node.vm.network "private_network", ip: "192.168.56.21"

chef_node.vm.provider "virtualbox" do |vb|
	vb.memory = "1024"

end
end

# NODE 2
config.vm.define "chef_node2" do |chef_node2|
  chef_node2.vm.hostname = "chef-node-web"
	chef_node2.vm.network "private_network", ip: "192.168.56.22"

chef_node2.vm.provider "virtualbox" do |vb|
	vb.memory = "1024"

end
end
end
