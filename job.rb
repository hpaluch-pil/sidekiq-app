require 'sidekiq'
# trivial Sidekiq job
# from: https://github.com/mperham/sidekiq/blob/main/examples/por.rb

# This is queued from Sinatra WebApp
# To queue this job, run:
# PlainOldRuby.perform_async "like a dog", 3
#
class PlainOldRuby
  include Sidekiq::Job

  def perform(how_hard="super hard", how_long=1)
    sleep how_long
    puts "Workin' #{how_hard}"
  end
end

# This is queued from sidekiq-cron server extension
# see sidekiq_boot.rb
class HelloCron
  include Sidekiq::Job

  def perform(msg="super hard", no=1)
    puts "Hello #{msg}, from Cron! Your No. #{no}."
  end
end
