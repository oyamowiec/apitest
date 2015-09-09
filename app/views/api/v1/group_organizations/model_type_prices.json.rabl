object @group_organization
attributes :id

node :organizations do
  hash = []
  @organizations.each do |o|
    hash << {
        id: o.id,
        price: o.price
    }
  end
  hash
end




