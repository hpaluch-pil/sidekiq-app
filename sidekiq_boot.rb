# sidekiq_boot.rb - booting file for Sidekiq and cron
# this file should be specifid to sidekiq process with '-r' argument
#

require 'sidekiq'
require 'sidekiq-cron'

# import our job classes
require './job.rb'

# SERVER: here Sidekiq reads Queue from Redis and invoke backround
# jobs
Sidekiq.configure_server do |config|

  cron_conf = [
    {
      'name'  => 'hello_cron_job',
      'class' => 'HelloCron', # defined in job.rb
      'cron'  => '*/2 * * * *', # run every even minute
      'args'  => [ 'arg1', 123 ]
    }
  ]

  Sidekiq::Cron::Job.load_from_array cron_conf

end


