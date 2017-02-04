require "myosx/version"
require "myosx/workspace"
require "myosx/dotfiles"
require "myosx/homebrew"
require "myosx/rbenv"

module Myosx
  class Bootstrap
    def initialize
      Workspace.new.create
      Dotfiles.new.exec
      Homebrew.new.exec
      Rbenv.new.exec
    end
  end
end
