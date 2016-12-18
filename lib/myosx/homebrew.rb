#!/usr/bin/env ruby
#
# Class which configures homebrew and brew bundle
#
require 'yaml'
require 'git'
require 'fileutils'
require_relative 'core'

class Homebrew
  def initialize
    Core.new
    @config = $global_config['homebrew']
  end

  def install
    unless `which brew`
      puts "Installing homebrew"
      Git.clone('https://github.com/Homebrew/install',
                'homebrew-install',
                :path => $workspace)
      dir = File.join($workspace, 'homebrew-install')
      install_script = File.join(dir, 'install')
      system("ruby", install_script)
    end
  end

  def bundle
    system("brew tap Homebrew/bundle")
    puts "Updating Brewfile"
    packages = @config['packages']
    brew_packages = packages['brew']
    tap_packages = packages['tap']

    File.open(File.join($workspace, 'Brewfile'), "w+") do |f|
      brew_packages.each { |p| f.puts "brew '#{p}'" }
      tap_packages.each { |p| f.puts "tap '#{p}'" }
    end
    brewfile = File.join($workspace, 'Brewfile')

    puts "Installing packages from #{brewfile}"
    system("brew bundle --file=#{brewfile}")
  end

  def exec
    if @config['manage']
      install
      bundle
    end
  end
end
