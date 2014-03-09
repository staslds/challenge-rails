# @author Stas from Lodoss Team
# @version 0.01 
# created 09 March, 2014
class Offer < ActiveRecord::Base
  belongs_to :merchant

  #populate offers table
  def self.pull xml
    xml = Nokogiri::XML xml
    offers = xml.xpath("//links/link")
    res = offers.map do |offer|
      obj = {}
      offer.children.map{|n|  obj[n.name.to_s] = n.text.to_s if n.elem? }
      obj
    end
    res.each do |el|
      result = _mapper el
      offer = Offer.find_or_initialize_by(id: result['id'])
      offer.update(result)
      #add new merchant if not exist yet
      if offer.merchant.blank?
        merchant = Merchant.find_or_initialize_by(id: offer.merchant_id)
        merchant.update(id: offer.merchant_id, name: el['advertiser-name'])
      end
    end
  end
end

private

#mapping cj fields with our db
def _mapper(offer)
  mapped_keys = {
    'link-id'           => 'id', 
    'description'       => 'description', 
    'link-name'         => 'title', 
    'destination'       => 'url', 
    'promotion-end-date'=> 'expires_at',
    'advertiser-id'     => 'merchant_id'
  }

  result = {}
  mapped_keys.each do |k,el|
    result[el] = offer[k]
  end
  result
end