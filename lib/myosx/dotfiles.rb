#!/usr/bin/env ruby
#
# Pulls a dotfiles repo and symlinks the files where you specify
#
require 'yaml'
require 'git'

require_relative 'konfig'

class Dotfiles
  def config
    Konfig.new.global['dotfiles']
  end

  def dotfiledir
    File.join(Konfig.new.workspace_directory, 'dotfiles')
  end

  def repo(repo, target, local_repo = 'dotfiles')
    if Git.ls_remote(repo)
      unless File.exist?(target)
        puts "Cloning #{repo}"
        Git.clone(repo, local_repo, :path => File.dirname(target))
      else
        g = Git.init(target)
        puts "Pulling latest #{repo}"
        g.pull
      end
    end
  end

  def link(file, dest)
    dest = File.expand_path(dest)
    raise "#{file} doesn't exist! Check your config or repo" unless File.exist?(file)

    if File.symlink?(dest)
      File.delete(dest)
    end

    if File.exist?(dest)
      backup_file = "#{dest}.#{Date.today.to_s}"
      puts "Creating backup of #{dest} called: #{backup_file}"
      File.rename(dest, backup_file)
    end

    puts "Linking #{file} to #{dest}"
    File.symlink(file, dest)
  end

  def exec
    if repo(config['repo'], dotfiledir)
      config['files'].each do |file, dest|
        link("#{dotfiledir}/#{file}", dest)
      end
    end
  end
end
