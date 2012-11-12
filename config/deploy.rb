ssh_options[:forward_agent] = true

default_run_options[:pty] = true

set :repository,  "git@github.com:diegodorado/americanbar.git"
set :scm, :git

set :application,  "cooph.com.ar"

server application , :app, :web, :db, :primary => true

set :user, "hormigon"
set :deploy_to, "/home/hormigon/americanbar"
set :deploy_via, :remote_cache
set :scm_verbose, true

set :use_sudo, false

set :keep_releases,  2

