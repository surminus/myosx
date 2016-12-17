require "myosx/version"
require "myosx/workspace"


module Myosx
  class Bootstrap
    def initialize
      puts "Bootstrapping"
      Workspace.new.create
    end
  end
end
