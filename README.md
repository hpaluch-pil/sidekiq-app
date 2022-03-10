# Demo app - Sidekiq and Sinatra together

Here is prototype of simple application that uses
Sinatra for web frontend and Sidekiq for Job processing backend.

The intent is to have as simple app as possible to test
how Sidekiq behaves - I want to learn how
to maintain Sidekiq in complex environment (like GitLab,
although they use Rails instead of Sinatra, so this example
is not one-to-one).

Main components are:

* [SIdekiq job scheduler](https://github.com/mperham/sidekiq)
  * [Sidekiq-Cron](https://github.com/ondrejbartas/sidekiq-cron) - provides regular
    cron scheduler for free (normally available in Enterprise Sidekiq version).
    This components is also used by GitLab.
* [Sinatra Web framework](http://sinatrarb.com/)
* [Rack](https://github.com/rack/rack) - modular web server interface

## Setup

Tested on Debian 11/amd64.

Install required packages:
```bash
sudo apt-get install gcc make ruby-dev ruby-bundler curl
```

Run bundler to install required ruby packages:
```bash
bundle install
```


Generate Secret session key (required by Sidekiq Web UI) using:
```bash
irb -r securerandom
# on IRB prompt enter:
File.open(".session.key", "w") {|f| f.write(SecureRandom.hex(32)) }
# enter "quit" to quit IRB
```
You can look into `.session.key` file - it should contain just one long hex string.

Now run in one terminal Sidekiq Worker (it will process Enqueued jobs):
```bash
./run_worker.sh
```

Open another terminal and run Web Server:
```bash
./run_webserver.sh
```

Point your browser to `http://IP_OF_SERVER:9292` and follow instructions.
- to enqueue job you have to submit form on above page, or use link `Enqeue new job using GET`
- you can then watch on Worker's terminal (that is running `./run_worker.sh`) that
  job was really processed

## Bugs

`Pipelining commands on a Redis instance is deprecated and will be removed in Redis 5.0.0.`
- Known bug in Sidekiq:
  - https://github.com/mperham/sidekiq/issues/5202

## Resources

There was used vast amount of Internet resources for this demo.
Please see comments in source code for links.

