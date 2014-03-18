require 'spec_helper'

describe "Provider pages" do

  subject { page }

  describe "signup page" do
    before { visit adduser_path }

    it { should have_content('Add user') }
    it { should have_title('Add user') }
  end
end