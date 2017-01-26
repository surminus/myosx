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

  def bundle
    system("brew tap Homebrew/bundle")
    puts "Updating Brewfile"
    packages = @config['packages']
    brew_packages = packages['brew']
    tap_packages = packages['tap']
    cask_packages = packages['cask']

    File.open(File.join($workspace, 'Brewfile'), "w+") do |f|
      brew_packages.each { |p| f.puts "brew '#{p}'" }
      tap_packages.each { |p| f.puts "tap '#{p}'" }
      cask_packages.each { |p| f.puts "cask '#{p}'" }
    end
    brewfile = File.join($workspace, 'Brewfile')

    puts "Installing packages from #{brewfile}"
    system("brew bundle --file=#{brewfile}")
  end

  def exec
    if @config['manage']
      bundle
    end
  end
end
