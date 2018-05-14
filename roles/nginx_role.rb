name "nginx_role"
description "This role setup and configure Nginx server"
run_list "recipe[nginx]"
env_run_lists "chef-dev" => ["recipe[nginx]"], "_default" => ["recipe[nginx]"]
