set :application, "imf"
set :repository,  "git@github.com:PlayMob/imf.git"
set :scm, :git
set :user, 'deploy'
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/deploy/#{application}"
set :rails_env, "development"
server "giverboard-staging.playmob.com", :app, :web, :db, :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/global_config.yml #{release_path}/config/global_config.yml"
  end

  desc "build missing paperclip styles"
  task :build_missing_paperclip_styles, :roles => :app do
    run "cd #{release_path}; RAILS_ENV=development bundle exec rake paperclip:refresh:missing_styles"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
#after "deploy:update_code", "deploy:build_missing_paperclip_styles"
