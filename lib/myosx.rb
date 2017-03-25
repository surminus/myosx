require "myosx/version"
require "myosx/config"
require "myosx/dotfiles"
require "myosx/homebrew"
require "myosx/rbenv"

module Myosx
  class Exec < Config
    def initialize
      Config.new.create_workspace

      if $global_config['dotfiles']
        Dotfiles.new.exec
      end

      if $global_config['homebrew']
        Homebrew.new.exec
      end

      if $global_config['rbenv']
        Rbenv.new.exec
      end
    end
  end
end
