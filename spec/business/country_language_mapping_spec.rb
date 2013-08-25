require 'spec_helper'

describe CountryLanguageMapping do
  before :each do
    @brazilian_version = double
    @global_version    = double

    GameVersion.stub :find_by_name do |name|
      if name == 'Brasil'
        @brazilian_version
      else
        @global_version
      end
    end
  end

  it 'should get default language for recognized country' do
    CountryLanguageMapping.language_for_country('bR').should == 'pt-br'
  end

  it 'should get default game version for recognized country' do
    CountryLanguageMapping.version_for_country('Br').should == @brazilian_version
  end

  it 'should get english as default language for unrecognized countries' do
    CountryLanguageMapping.language_for_country('$!').should == 'en'
  end

  it 'should get global version for unrecognized countries' do
    CountryLanguageMapping.version_for_country('$!').should == @global_version
  end
end
