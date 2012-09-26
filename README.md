# Foreman::Export::Great

Custom runit exporter with support for rbenv and runit dependent services. This is customized for our uses so some
unexpected things happen - like the fact that we don't use specific ports or several numbered services of the same type,
so you WILL NOT get anything like:

/path/to/services/<appname>-web-1
/path/to/services/<appname>-web-2
/path/to/services/<appname>-web-3

This will ONLY create ONE such service, that's the way we run. We generally use stuff that forks as many processes it needs
on it's own. We just want runit to supervise the whole thing.

## Installation

Add this line to your application's Gemfile:
    
    gem 'foreman'
    gem 'foreman-export-great'

And then execute:

    $ bundle

## Usage

Define the usual stuff in Procfile (and remember the names), if you need one service to depend on another... let's say
you've got some workers that should start and stop together with the main web app, so you've got your Procfile looking
like this:

    web: bundle exec unicorn -c unicorn.conf
    workers: ./script/workers

Now you want those workers to start/restart/stop when your main app does eg. when you do sv start <appname>-web you want to
automatically also run sv start <appname>-workers. To get this to work, open up .env in your project directory and add:

    WEB_DEPENDENT_SERVICE: <appname>-workers

Done!

To export to runit, just do something like this:

    bundle exec foreman export great-runit /path/to/services -l /path/to/logdir -a appname -u user

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
