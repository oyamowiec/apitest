class GroupOrganization < ActiveRecord::Base
  belongs_to :country
  has_many :organizations
  has_many :locations, through: :organizations
end
