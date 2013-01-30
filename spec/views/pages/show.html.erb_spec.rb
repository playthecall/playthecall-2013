require 'spec_helper'

describe "pages/show" do
  before(:each) do
    @page = assign(:page, stub_model(Page,
      :name => "MyPage",
      :locale => "en",
      :html_description => "MyText",
      :content => 'SomeContent',
      :slug => 'testing'
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/SomeContent/)
    rendered.should match(/MyPage/)
  end
end
