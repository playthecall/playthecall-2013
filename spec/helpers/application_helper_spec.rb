require 'spec_helper'

describe ApplicationHelper do
  describe "#localized_url" do
    
    subject { helper.localized_url('playthecall.com/some-test-url') }

    { :'pt-BR' => 'playthecall.com.br/some-test-url',
      :en => 'playthecall.com/some-test-url',
      :'zh-CN' => 'playthecall.com/some-test-url',
      :'zh-TW' => 'playthecall.com/some-test-url'
    }.each_pair do |key, value|
      it "returns the #{key} version of url" do
        I18n.locale = key.to_s
        subject.should == value 
      end
    end
  end
end
