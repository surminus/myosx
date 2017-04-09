require "myosx/version"
require "myosx/config"
require "myosx/dotfiles"
require "myosx/homebrew"
require "myosx/rbenv"

module Myosx
  class Exec < Config
    def initialize
      Config.new.create_workspace(Config.new.workspace_directory)

      unless system("which brew >/dev/null 2>&1")
        puts "Error: can't find homebrew in PATH."
        exit
      end

      if Config.new.global['dotfiles']
        Dotfiles.new.exec
      end

      if Config.new.global['homebrew']
        Homebrew.new.exec
      end

      if Config.new.global['rbenv']
        Rbenv.new.exec
      end
    end
  end
end
