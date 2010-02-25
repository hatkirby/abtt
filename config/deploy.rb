set :application, "ABTT"
set :repository,  "file:///git/abtt_new"

#deploy_to is /u/apps/ABTT...

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#set :branch, "name"

role :web, "abtt.abtech.org"                          # Your HTTP server, Apache/etc
role :app, "abtt.abtech.org"                          # This may be the same as your `Web` server
role :db,  "abtt.abtech.org", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :use_sudo, false #You need to be in group webmaster

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start  do end
  task :stop do end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{release_path}/tmp/restart.txt"
  end
  after "deploy:setup" do
    run "touch #{deploy_to}/#{shared_dir}/database.yml"
  end
  after "deploy:update_code" do
    run "rm -f #{release_path}/config/database.yml && ln -s #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  end
end
