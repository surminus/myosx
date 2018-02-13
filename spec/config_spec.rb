require "spec_helper"

describe "Konfig class" do
  describe "workspace_directory" do
    it "if the MYOSX_WORKSPACE env var is set return the full path" do
      ENV['MYOSX_WORKSPACE'] = "/Users/alan/workspace"
      expect(Konfig.new.workspace_directory).to eq("\/Users\/alan\/workspace")
    end

    it "if the MYOSX_WORKSPACE is not set default to users home" do
      ENV.delete('MYOSX_WORKSPACE')
      expect(Konfig.new.workspace_directory).to eq("#{ENV['HOME']}/.myosx")
    end
  end

  describe 'config_location' do
    it "if the MYOSX_CONFIG env var is set return the full path" do
      ENV['MYOSX_CONFIG'] = "/Users/alan/config_file.cnf"
      expect(Konfig.new.config_file).to eq("\/Users\/alan\/config_file.cnf")
    end

    it "if the MYOSX_CONFIG env var is not set return the default file name in users home" do
      ENV.delete('MYOSX_CONFIG')
      expect(Konfig.new.config_file).to eq("#{ENV['HOME']}\/\.myosx.cnf")
    end
  end
end
