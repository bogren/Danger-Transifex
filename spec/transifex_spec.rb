require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe Danger::DangerTransifex do
    it 'should be a plugin' do
      expect(Danger::DangerTransifex.new(nil)).to be_a Danger::Plugin
    end

    describe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @my_plugin = @dangerfile.transifex
      end

      context "Failed request" do
        before do
          allow_any_instance_of(Transifex::ResourceComponents::Content).to recieve(:update).with(anything).and raise_error
        end

        it "Warns on fail" do
          @my_plugin.push_source("TXT", "path/to/translations.txt")
          expect(@dangerfile.status_report[:warnings]).to eq(["Updating translations failed \u{274C}"])
        end
      end

      context "Successful request" do
        before do
          allow_any_instance_of(Transifex::ResourceComponents::Content).to recieve(:update).with(anything).and anything
        end

        it "Messages on success" do
          @my_plugin.push_source("TXT", "path/to/translations.txt")
          expect(@dangerfile.status_report[:messages]).to eq(["Translations updated \u{2705}"])
        end
      end

    end
  end
end
