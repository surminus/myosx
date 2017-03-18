#!/usr/bin/env ruby
#
# Class which installs rbenv packages, and installs ruby versions
#
# This class does not add the shims path to your shell or manage any aliases
#
require 'yaml'
require_relative 'config'

class Rbenv < Config
  def initialize
    @config = $global_config['rbenv']
  end

  def install
    packages = ['rbenv', 'rbenv-aliases', 'rbenv-bundler']
    packages.each do |pkg|
      unless system("brew list #{pkg} >/dev/null 2>&1")
        puts "Installing #{pkg}"
        system("brew install #{pkg}")
      end
    end

    versions = @config['versions']
    puts "Checking Ruby version:"
    versions.each do |version|
      puts "  #{version}"
      system("rbenv install #{version} --skip-existing")
    end
  end

  def exec
    if @config['manage']
      install
    end
  end
end
