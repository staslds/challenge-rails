require 'spec_helper'

describe Offer do
  #define API response as variable
  let(:response){
    response = RestClient.get 'https://linksearch.api.cj.com/v2/link-search?website-id=5742006&records-per-page=20', :authorization => Rails.application.config.cj_token
    if response.code == 200
      response
    else
      false
    end
  }
  
  it "crawl the API should return some result" do
    expect(response.code).to be 200
  end

  context "crawl the API" do
    it "should stored offers in db" do
      Offer.pull response
      expect(Offer.all.count).to be > 0
    end

    it "multiple times should not create duplicate offers" do
      Offer.pull response
      offers_count = Offer.all.count
      #try save more 2 times the same results
      2.times {Offer.pull response}
      expect(offers_count).to be Offer.all.count
    end

  end

end