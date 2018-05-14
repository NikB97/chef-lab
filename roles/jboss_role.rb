name "jboss_role"
description "This role setup and configure Jboss server and also deploy sample.war"
run_list "recipe[jboss_cookbook]"
env_run_lists "chef-dev" => ["recipe[jboss_cookbook]"], "_default" => ["recipe[jboss_cookbook]"]
