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

  it "should have a list of supported standards" do
    standards = Converter.standards

    standards.should be_an(Array)
    standards.should_not be_empty
  end
  
  it "should have a name" do
    c = Converter.new("UTF-8")
    c.name.should == "UTF-8"
  end

  describe "#standard_name" do
    expected_names = {
      "latin1" => "ISO_8859-1:1987",
      "ISO-8859-1" => "ISO_8859-1:1987",
      "ISO88591" => "ISO_8859-1:1987",
      "windows-1252" => "windows-1252",
      "cp-1252" => "windows-1252",
      "utf8" => "UTF-8"
    }

    expected_names.each do |encoding, expected|
      it "should normalize #{encoding} to #{expected}" do
        c = Converter.new(encoding)
        c.standard_name(:iana).should == expected
      end
    end
  end

  describe "#canonical_name" do
    expected_names = {
      "latin1" => "ISO-8859-1",
      "ISO-8859-1" => "ISO-8859-1",
      "ISO88591" => "ISO-8859-1"
    }

    expected_names.each do |encoding, expected|
      it "should normalize #{encoding} to #{expected}" do
        c = Converter.new(encoding)
        c.canonical_name.should == expected
      end
    end
  end
end
