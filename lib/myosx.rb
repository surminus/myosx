require "myosx/version"
require "myosx/workspace"
require "myosx/dotfiles"

module Myosx
  class Bootstrap
    def initialize
      puts "Bootstrapping"
      Workspace.new.create
      Dotfiles.new.link
    end
  end
end
