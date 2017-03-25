#require "spec_helper"
require_relative "../lib/myosx/homebrew"

global_config = YAML.load_file('spec/example.config.yaml')
config = global_config['homebrew']
packages = config['packages']

describe "homebrew" do
  it "takes a list of packages and returns in Brewfile format" do
    expect(Homebrew.new.brewfile_out(packages)).to eq("brew 'jimi'\nbrew 'hendrix'\ncask 'eric'\ncask 'clapton'\ntap 'bob'\ntap 'marley'\n")
  end

end
