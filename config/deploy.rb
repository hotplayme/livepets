# config valid only for current version of Capistrano
lock '3.4.0'

set :tmp_dir, '/home/rails/tmp'

set :application, 'livepets'
set :repo_url, 'https://github.com/merch2/pets.git'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/rails'
set :deploy_user, 'rails'

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', '.env', 'public/robots.txt')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads', 'public/images', 'public/photos', 'public/avatars')

set :keep_releases, 5

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.2.3'


namespace :deploy do

  desc 'Restart app'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart

end
