# encoding: UTF-8

require 'spec_helper'

describe ICU::Conversion::Converter do
  Converter = ICU::Conversion::Converter

  it "should throw error on invalid name" do
    expect{ Converter.new("BogusBlah") }.to raise_error(ICU::Error)
  end

  it "should have a list of all defined converter names" do
    all_names = Converter.all_names

    all_names.should be_an(Array)
    all_names.should_not be_empty
  end
  
  describe "#name" do
    it "should return given name if canonical" do
      c = Converter.new("UTF-8")
      c.name.should == "UTF-8"
    end

    it "should normalize the name" do
      c = Converter.new("UTF8")
      c.name.should == "UTF-8"
    end
  end

  describe "#standard_name" do
    pending "need to get a clue"
  end

  describe "#canonical_name" do
    pending "need to get a clue"
  end
end
