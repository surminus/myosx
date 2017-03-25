#!/usr/bin/env ruby
#
# Class which configures homebrew and brew bundle
#
require 'yaml'
require 'git'
require_relative 'config'

class Homebrew < Config

  def packages
    @config = $global_config['homebrew']
    return @config['packages']
  end

  def brewfile
    return File.join($workspace, 'Brewfile')
  end

  def brewfile_out(packages)
    output = ''
    packages.each do |type, package_array|
      package_array.each do |package|
        output << "#{type} '#{package}'\n"
      end
    end
    return output
  end

  def bundle
    system("brew tap Homebrew/bundle")
    puts "Updating Brewfile"

    File.open(brewfile, "w+") {
      |file| file.write(brewfile_out(packages))
    }

    puts "Installing packages from #{brewfile}"
    system("brew", "bundle", "--file=#{brewfile}")
  end

  def exec
    bundle
  end
end
