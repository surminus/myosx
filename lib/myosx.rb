require "myosx/version"
require "myosx/config"
require "myosx/dotfiles"
require "myosx/homebrew"
require "myosx/rbenv"

module Myosx
  class Exec < Config
    def initialize
      Config.new.create_workspace
      Dotfiles.new.exec
      Homebrew.new.exec
      Rbenv.new.exec
    end
  end
end
