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


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/surminus/myosx. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

