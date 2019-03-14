# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'MailBlag'
set :repo_url, 'https://github.com/gregshutt/mailblag.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/mailroom.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'vendor/bundle'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :passenger_restart_with_touch, true

# load the variable from the stage
#  see http://capistranorb.com/documentation/faq/how-can-i-access-stage-configuration-variables/
set :foreman_user, -> { fetch(:deploy_user) }

# install the foreman jobs
#  see https://rvm.io/integration/sudo
set :default_env, { 
  'rvmsudo_secure_path' => '0'
}

#  see https://github.com/capistrano/rvm/issues/53
set :rvm_map_bins, fetch(:rvm_map_bins, []).push('rvmsudo')

namespace :foreman do
  desc "Export the Procfile to systemd"
  task :export do
    on roles :app do
      within release_path do
        execute :rvmsudo, "foreman export systemd /lib/systemd/system -m mail_room=1 -a mailblag -u #{fetch(:foreman_user)} -l #{File.join(shared_path, 'log')}"
      end
    end
  end

  task :restart do
    on roles :app do
      execute :sudo, "systemctl daemon-reload"
      execute :sudo, "systemctl restart mailblag.target"
    end
  end
end

after "deploy:finished", "foreman:export"
after "deploy:finished", "foreman:restart"