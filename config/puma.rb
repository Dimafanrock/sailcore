max_threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
min_threads_count = ENV.fetch('RAILS_MIN_THREADS', max_threads_count)
threads min_threads_count, max_threads_count
environment ENV.fetch('RAILS_ENV', 'development')
port ENV.fetch('PORT', 3000)
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')
plugin :tmp_restart

if ENV['RAILS_ENV'] == 'production'
  require 'concurrent-ruby'
  worker_count = Integer(ENV.fetch('WEB_CONCURRENCY', Concurrent.physical_processor_count))
  workers worker_count if worker_count > 1
end

worker_timeout 3600 if ENV.fetch('RAILS_ENV', 'development') == 'development'
