# @author Stas from Lodoss Team
# @version 0.01 
# created 09 March, 2014
class Merchant < ActiveRecord::Base
   has_many :offers, dependent: :destroy
end
