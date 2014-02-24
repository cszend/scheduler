require 'spec_helper'

describe "Static pages" do

	subject{ page }

  describe "Home page" do
		before { visit root_path}
	
		it { should have_content('E-Scheduler') }
		it { should have_title("Scheduler") }
    end

	
  describe "Contact page" do
		before { visit contact_path}

		it { should have_content('Contact') }
		it { should have_title("Contact") }
  end

  describe "Pricing page" do
		before { visit pricing_path}

		it { should have_content('Pricing') }
		it { should have_title("Pricing") }
  end

	describe "About page" do
    before { visit about_path}

		it { should have_content('About') }
		it { should have_title("About") }
	end
	
end