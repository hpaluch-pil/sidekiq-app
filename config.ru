# config.ru - Rackup configuration for Web app
require './demo_app'

require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400
require 'sidekiq/web'
run Rack::URLMap.new(
  '/' => DemoApp,
  '/sidekiq' => Sidekiq::Web)

