require File.expand_path(File.dirname(__FILE__) + "/environment.rb")

set :output, "#{Rails.root}/log/cron.log"
set :environment, :development
ENV.each { |k, v| env(k, v) }
job_type :runner ,"export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rails runner :task :output" 

every 5.minutes do
  runner "StatusTransition.ticket_available?"
  runner "StatusTransition.ticket_expired?"
end
