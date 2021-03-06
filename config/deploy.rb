set :application, "CTHN website"

set :scm, :git
set :repository,  "https://github.com/aaronmueller/cthn-website.git"
set :branch,      "master"

set :deploy_to,   "/srv/www/vhosts/www.cthn.de/cthn-website/"
set :rake,        'bundle exec rake'
set :use_sudo,    false
set :user,        "cthn"

role :web, "phonos.sickos.org"
role :app, "phonos.sickos.org"
role :db,  "phonos.sickos.org", :primary => true 


namespace :bundler do
  task :add_path, :roles => :app do
    set :default_environment, {
      'PATH' => "$PATH:#{File.join(shared_path, 'bundle', 'ruby', '1.8', 'bin')}",
      'GEM_HOME' => File.join(shared_path, 'bundle', 'ruby', '1.8')
    }
  end

  task :setup, :roles => :app do
    run "mkdir -p #{File.join(shared_path, 'bundle')}"
  end

  task :create_symlink, :roles => :app do
    run "ln -s #{File.join(shared_path, 'bundle')} #{File.join(release_path, '.bundle')}"
  end

  task :bundle, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --path #{File.join(shared_path, 'bundle')} --without development test"
  end
end

before 'deploy', 'bundler:add_path'
after 'deploy:setup', 'bundler:setup'
after 'deploy:update_code', 'bundler:bundle'


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  task :precompile_assets, :roles => :app do
    run "cd #{current_path} && rm -rf public/assets/*"
    run "cd #{current_path} && RAILS_ENV=#{rails_env} #{rake} assets:precompile"
  end
end

after 'deploy:update_code', 'deploy:migrate'
before 'deploy:start', 'deploy:precompile_assets'
before 'deploy:restart', 'deploy:precompile_assets'
