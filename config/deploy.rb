set :application, "CTHN website"
set :repository,  "https://github.com/aaronmueller/cthn-website"
set :deploy_to, "/srv/www/vhosts/www.cthn.de/cthn-website/"
set :branch, "master"

set :use_sudo, false
set :user, "cthn"

set :scm, :git

role :web, "phonos.sickos.org"
role :app, "phonos.sickos.org"
role :db,  "phonos.sickos.org", :primary => true 

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after 'deploy:update_code', 'deploy:migrate'
