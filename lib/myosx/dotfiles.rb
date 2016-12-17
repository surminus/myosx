#!/usr/bin/env ruby

require 'yaml'
require 'git'
require 'fileutils'

def config
  YAML.load_file('config.yaml')
end

def workspace
  File.join(Dir.home, config['workspace'])
end

def dotfiledir
  File.join(workspace, 'dotfiles')
end

def create_workspace
  Dir.mkdir("#{workspace}", 0750) unless Dir.exists?("#{workspace}")
end

def get_repo
  dotfile_repo = config['dotfile_repo']
  unless File.exist?(dotfiledir)
    puts "Cloning #{dotfile_repo}"
    Git.clone(dotfile_repo, 'dotfiles', :path => workspace)
  else
    g = Git.init(dotfiledir)
    puts "Pulling latest #{dotfile_repo}"
    g.pull
  end
end


def link_dotfiles
  dotfiles = config['dotfiles']

  dotfiles.each do |file|
    source_file = "#{dotfiledir}/#{file}"

    raise "#{source_file} doesn't exist! Check your config or repo" unless File.exist?(source_file) 

    link_file = File.join(Dir.home, file.prepend('.'))

    if File.exist?(link_file)
      FileUtils.remove_file(link_file)
    end

    puts "Linking #{source_file} to #{link_file}"
    FileUtils.ln_sf(source_file, link_file)
  end
end

create_workspace
get_repo
link_dotfiles
