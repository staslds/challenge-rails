# @author Stas from Lodoss Team
# @version 0.01 
# created 09 March, 2014
class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

end
