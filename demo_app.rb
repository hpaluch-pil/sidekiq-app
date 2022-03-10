# app.rb - trivial Sinatra Web app
#          from https://devcenter.heroku.com/articles/rack
require 'sinatra'
require 'sidekiq/api'

require './job.rb'

# https://lanej.io/programming/2016/10/30/sinatra_xss_escaping/
# provide h and other escape macros in ERB templates
class DemoApp < Sinatra::Base
  include ERB::Util

  # from: https://stackoverflow.com/a/18113520
  def is_number?(obj)
    obj.to_s == obj.to_i.to_s
  end

  # from https://github.com/mperham/sidekiq/wiki/Monitoring#monitoring-queue-backlog
  # try: curl -fsSv 127.0.0.1:9292/queue-status
  get '/queue-status' do
    [200, {"Content-Type" => "text/plain"}, [Sidekiq::Queue.new.size < 100 ? "OK\n" : "UHOH\n" ]]
  end

  # try: curl -fsSv 127.0.0.1:9292/queue-size
  get '/queue-size' do
    [200, {"Content-Type" => "text/plain"}, [Sidekiq::Queue.new.size.to_s ]]
  end

  # FIXME: Should be POST or PUT
  # try: curl -fsSv 127.0.0.1:9292/work
  get '/work' do
    PlainOldRuby.perform_async "like a dog", 3
    "Job Queued"
  end

  # handle posted form
  post '/formwork' do
    slp = params[:sleep] || '2'
    return "Sleep value '#{h(slp)}' is NOT a number" unless is_number? slp
    slp_int = slp.to_i
    return "Sleep value #{slp_int} out of allowed range" if slp_int < 1 || slp_int > 10
    PlainOldRuby.perform_async "like a dog", slp_int
    erb :queued
  end

  # from https://devcenter.heroku.com/articles/rack
  # try: curl -fsSv 127.0.0.1:9292
  get '/' do
    params[:sleep] = params[:sleep] || '2'
    erb :index
  end

end
