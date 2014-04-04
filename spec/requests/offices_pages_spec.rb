require 'spec_helper'

describe "Office pages" do

  subject { page }

  describe "signup page" do
    before { visit addoffice_path }

    it { should have_content('Add office') }
    it { should have_title('Add office') }
  end
end