require "myosx/version"
require "myosx/workspace"
require "myosx/dotfiles"
require "myosx/homebrew"

module Myosx
  class Bootstrap
    def initialize
      Workspace.new.create
      Dotfiles.new.exec
      Homebrew.new.exec
    end
  end
end
