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

	describe "Sign up page" do
    before { visit signup_path}

		it { should have_content('Sign up') }
		it { should have_title("Sign up") }
	end

	
	it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title("About")
    click_link "Pricing"
    expect(page).to have_title("Pricing")
    click_link "Contact"
    expect(page).to have_title("Contact")
  end

end