class CreateGroupOrganizations < ActiveRecord::Migration
  def change
    create_table :group_organizations do |t|
      t.string :name
      t.string :organization_code
      t.integer :country_id

      t.timestamps null: false
    end
  end
end
