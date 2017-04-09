#!/usr/bin/env ruby
#
# Class which installs rbenv packages, and installs ruby versions
#
# This class does not add the shims path to your shell or manage any aliases
#
require 'yaml'
require_relative 'config'

class Rbenv < Config
  def config
    Config.new.global['rbenv']
  end

  def install_rbenv
    packages = ['rbenv', 'rbenv-aliases', 'rbenv-bundler']
    packages.each do |pkg|
      unless system("brew list #{pkg} >/dev/null 2>&1")
        puts "Installing #{pkg}"
        system("brew install #{pkg}")
      end
    end
  end

  def install_rubies
    versions = config['versions']
    puts "Ensuring Ruby version(s) installed:"
    versions.each do |version|
      puts " - #{version}"
      system("rbenv install #{version} --skip-existing")
    end
  end

  def exec
    install_rbenv
    install_rubies
  end
end
