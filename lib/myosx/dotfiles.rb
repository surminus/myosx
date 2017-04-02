#!/usr/bin/env ruby
#
# Pulls a dotfiles repo and symlinks the files where you specify
#
require 'yaml'
require 'git'
require_relative 'config'

class Dotfiles < Config
  def config
    Config.new.global['dotfiles']
  end

  def dotfiledir
    File.join(Config.new.workspace_directory, 'dotfiles')
  end

  def repo(repo)
    if Git.ls_remote(repo)
      unless File.exist?(dotfiledir)
        puts "Cloning #{dotfile_repo}"
        Git.clone(repo, 'dotfiles', :path => Config.new.workspace_directory)
      else
        g = Git.init(dotfiledir)
        puts "Pulling latest #{repo}"
        g.pull
      end
    end
  end

  def link(file, dest)
    dest = File.expand_path(dest)
    raise "#{file} doesn't exist! Check your config or repo" unless File.exist?(file)

    if File.exist?(dest)
      File.delete(dest)
    end

    puts "Linking #{file} to #{dest}"
    File.symlink(file, dest)
  end

  def exec
    if repo(config['repo'])
      config['files'].each do |file, dest|
        link("#{dotfiledir}/#{file}", dest)
      end
    end
  end
end
