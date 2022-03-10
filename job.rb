require 'sidekiq'
# trivial Sidekiq job
# from: https://github.com/mperham/sidekiq/blob/main/examples/por.rb

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
