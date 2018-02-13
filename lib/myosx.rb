require "myosx/version"
require "myosx/konfig"
require "myosx/dotfiles"
require "myosx/homebrew"
require "myosx/rbenv"

module Myosx
  class Exec
    def initialize
      Konfig.new.create_workspace(Konfig.new.workspace_directory)

      unless system("which brew >/dev/null 2>&1")
        puts "Error: can't find homebrew in PATH."
        exit
      end

      if Konfig.new.global['dotfiles']
        Dotfiles.new.exec
      end

      if Konfig.new.global['homebrew']
        Homebrew.new.exec
      end

      if Konfig.new.global['rbenv']
        Rbenv.new.exec
      end
    end
  end
end
