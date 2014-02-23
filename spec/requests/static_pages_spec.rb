require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

		it "should have the content 'E-Scheduler'" do
      visit '/static_pages/home'
      expect(page).to have_content('E-Scheduler')
    end

		it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Home")
    end

	end
	
  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end

		it "should have the title 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_title("Contact")
    end

  end

  describe "Pricing page" do
    it "should have the content 'Pricing'" do
      visit '/static_pages/pricing'
      expect(page).to have_content('Pricing')
    end

		it "should have the title 'Pricing'" do
      visit '/static_pages/pricing'
      expect(page).to have_title("Pricing")
    end

  end

	describe "About page" do
    it "should have the content 'About'" do
      visit '/static_pages/about'
      expect(page).to have_content('About')
    end
  
		it "should have the title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title("About")
    end

	end
	
end