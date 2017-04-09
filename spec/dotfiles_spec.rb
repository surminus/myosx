require "spec_helper"

describe "dotfiles" do
  let(:file) { 'spec/stub/ackrc' }
  let(:dest) { 'spec/stub/.ackrc' }
  let(:dest_no_symlink) { "spec/stub/.ackrc_no_symlink" }

  it "dotfiledir returns the directory inside the default workspace" do
    expect(Dotfiles.new.dotfiledir).to eq("#{ENV['HOME']}/.myosx/dotfiles")
  end

  it "link should create symlink from file to the given destination" do
    expect(Dotfiles.new.link(file, dest)).to eq(0)
    expect(File.symlink?(dest)).to be true
  end

  it "link should rename the destination file if it already exists and is not a symlink" do

    # We want to test renaming a file which isn't already a symlink,
    # so we can do this with creating empty files. First we should
    # clean up and then create an empty file.
    Dir["#{dest_no_symlink}.*"].each do |old_file|
      File.delete(old_file)
    end
    File.delete(dest_no_symlink) if File.symlink?(dest_no_symlink)
    File.open(dest_no_symlink, "w") unless File.exist?(dest_no_symlink)

    expect(Dotfiles.new.link(file, dest_no_symlink)).to eq(0)
    expect(File.exist?("#{dest_no_symlink}.#{Date.today.to_s}")).to be true
  end

  let(:repo) { 'https://github.com/surminus/dotfiles.git' }
  let(:repo_target) { 'spec/stub/dotfiles' }
  it "repo should clone a repository to the target using the default repo path name of 'dotfiles'" do
    if File.exist?(repo_target)
      # We need to empty the directory before deleting and using system
      # means we do not need to include FileUtils for this single task
      system("rm -rf #{repo_target}")
    end
    Dotfiles.new.repo(repo, repo_target)
    expect(File.exist?("#{repo_target}/.git")).to be true
  end
end
