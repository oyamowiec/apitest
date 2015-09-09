class Organization < ActiveRecord::Base
  belongs_to :group_organization
  has_many :children, class_name: 'Organization', foreign_key: :organization_id
  belongs_to :parent, class_name: 'Organization', foreign_key: :organization_id
  has_many :locations

  @@flexible = 0
  @@fixed = 0
  @@prestige = 0

  def init_pricing(base_price)
    @@flexible = PricingPolicyRequest.flexible + base_price.to_d
    @@fixed = PricingPolicyRequest.fixed + base_price.to_d
    @@prestige = PricingPolicyRequest.prestige + base_price.to_d
  end

  def price
    if self.pricing_policy == 'Flexible'
      return @@flexible
    elsif self.pricing_policy == 'Fixed'
      return @@fixed
    elsif self.pricing_policy == 'Prestige'
       return @@prestige
    else
      return nil
    end

  end

end
