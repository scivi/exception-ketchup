## Ketchup exception handling ![Still maintained](http://stillmaintained.com/dsci/Jason.png) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/datenspiel/exception-ketchup)

Rails exception handling happens with ActionController extension and Mongoid support. 

With version 0.2 comes Mongoid 3 support.

## Install & Configuration

Add 

```ruby
gem "exception-ketchup" 
```

to your Gemfile.

Add a file to <code>Rails.root/initializers/</code>.

Configure <code>Ketchup::Exception</code>:

```ruby

# Config Exception handling here. 
Ketchup::Exception.setup do |config|
  # A list  email of addresses to which the exception notification should be mailed. 
  config.recipients    = %W(daniel.schmidt@datenspiel.com lars.mueller@datenspiel.com)
  # Subject to use for email.
  config.subject       = "Error happens at myovulasens"
  # The path to the mail template
  config.template_path = "notifications" 
  # The following are optional configurations
  # Disables or enables delivering of exception messages. Defaults to true.
  # config.deliver_mail = false
  # Disables or enables persisting of exception messages. Defaults to true
  # config.persist = false
  # Define the collection name hwere to exception messages should be stored.
  # Defaults to :errors
  # config.exception_collection = :errors
  # Define a Proc here that is responsible for logging messages. 
  # See exception-ketchup.rb for details about.
  # config.log_error = lambda do |error|
  #   # do something with err. 
  # end
  # The Rails env(s) to use. Optional for configuration, defaults to :production
  # config.environment = [:production]
end
```

## Make it available

Add to your controller class:

```ruby

class ApplicationController

  ketchup_exceptions do |c|
    c.rescue_errors   = [
      {:error => RestClient::ServerBrokeConnection, :with => :server_not_responding},
      {:error => CanCan::AccessDenied, :with    => :unauthorized,
                                       :notify  => false,
                                       :remember => false,
                                       :log     => true}
    ]
  end

end

```

<code>rescue_errors</code>  -  Configure which exceptions you want to treat in a special way by using the following options
   *   <code>error</code>:    Class, mandatory.
                              Error-Class to handle
   *   <code>with</code>:     Symbol|Proc.
                              Method to execute for individual error handling. This method should take
                              one argument which is the error that was raised.
                              If this is omitted, be sure to implement a <code>:respond_with_error</code> method.
   *   <code>remember</code>: Boolean, default: <code>true</code>
                              Wether or not write the error to the database
   *   <code>notify</code>:   Boolean, default: <code>true</code>
                              Wether or not to send an email to the configured recipients
   *   <code>log</code>:      Boolean, default: <code>true</code>
                              Wether or not to log the exception

**Note:** 

If <code>config.deliver_mail</code> is set to false, <code>:notify</code> will be ignored.
If <code>config.persist</code> is set to false, <code>:remember</code> will be ignored.

## Contributing to exception-ketchup
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Daniel Schmidt. See LICENSE.txt for
further details.

