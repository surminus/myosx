# Myosx

myosx configures osx how I like it.

## Setup

1. Install XCode
2. [Install homebrew](http://brew.sh/)
3. `bundle install`

## Usage

Notes on how to test before it's a gem. Clone repo and from inside:

`RUBYLIB=$(pwd)/lib bin/myosx`

## Config

You can set two key configs from environment variables:

### Config file
`MYOSX_CONFIG`

If this isn't set then it defaults to `~/.myosx.cnf`

Use the example config file to set some things (`example.myosx.cnf`)

### Workspace directory
`MYOSX_WORKSPACE`

This is where everything is stored such as Brewfiles and any other repositories
that it may pull.

## To-do

Loads of stuff.

 - Create files in library for ideas on what to manage
 - Ideally the config file should be ~/.myosx.yaml or something
 - usage should be install gem, create config, `$ myosx`
 - tests

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/surminus/myosx. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

