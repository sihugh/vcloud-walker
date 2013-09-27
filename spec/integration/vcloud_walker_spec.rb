require_relative '../spec_helper'
require 'fog'
require 'stringio'

describe Walk::Vdcs do
  context 'walk an organization' do

    it 'should describe vdcs' do
      vdc_summary = Walk::Vdcs.new('4-3-51-7942a4').to_summary
      vdc_summary.should == Data.Load('walker_ci', 'vdcs')
    end

    it "should describe networks" do
      network_summary = Walk::Networks.new('4-3-51-7942a4').to_summary
      network_summary.should == Data.Load('walker_ci', 'networks')
    end

    it "should describe catalogs" do
      catalog_summary = Walk::Catalogs.new('4-3-51-7942a4').to_summary

      expected_catalog_summary = Data.Load('walker_ci', 'catalogs')

      #comparing catalogs added by us, ignoring the skyscape public catalogs
      select_walker_ci_catalog(catalog_summary).should == select_walker_ci_catalog(expected_catalog_summary)
    end

    private
    def select_walker_ci_catalog(catalog_summary)
      catalog_summary.select { |catalog| catalog[:name] == 'walker-ci' }
    end
  end
end