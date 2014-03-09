# @author Stas from Lodoss Team
# @version 0.01 
# created 09 March, 2014
class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def crawl
    url = 'https://linksearch.api.cj.com/v2/link-search?website-id=5742006&records-per-page=20'
    #make API request and populate our DB
    response = RestClient.get url, :authorization => Rails.application.config.cj_token
    if response.code == 200
      Offer.pull response
    end
    redirect_to offers_path
  end

end
