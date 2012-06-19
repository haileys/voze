task :deploy do
  production_host = "voze.org"
  production_user = "voze"
  production_dir = "/srv/http/voze"
  
  cmds = [
    "cd #{production_dir}",
    "git reset --hard",
    "git pull",
    "sudo bundle install",
    "bundle exec rake assets:precompile RAILS_ENV=production",
    "bundle exec rake db:migrate RAILS_ENV=production",
    "touch tmp/restart.txt"
  ]
  
  system "ssh #{production_user}@#{production_host} '#{cmds.join " && "}'"
end