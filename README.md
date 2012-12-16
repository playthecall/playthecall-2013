This read me intend to help you to setup the development environment.

## HOW TO

Clone the app

    $ git clone git://github.com/playthecall/playthecall.git

And execute bundle:

    $ bundle

Copy and configure the database.yml:

    $ cp config/database.yml.sample config/database.yml

Copy and configure the development.yml:

    $ cp config/application/development.yml.sample config/application/development.yml

_Learn more about Rails Environment Variables [HERE](http://railsapps.github.com/rails-environment-variables.html)_

Setup your database:

    $ rake db:setup

Import cities running the rake task:

    $ rake import:cities

Now it is ready to contribute

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request