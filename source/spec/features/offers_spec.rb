require 'spec_helper'

describe "Offers page" do
  context "displays the offers" do
    it "after click on Crawl button" do
      visit  "/offers"
      click_link 'Crawl'
      expect(page.has_selector?('.coupon')).to be
    end

    it "after reload the page" do
      visit  "/offers"
      expect(page.has_selector?('.coupon')).to be
    end
  end
end