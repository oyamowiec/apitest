require 'rails_helper'

RSpec.describe API::V1::GroupOrganizationsController, :type => :controller do
  render_views

  describe "POST #model_type_prices" do

    let(:country) { Country.create!(name: 'Polska', country_code: "PL") }
    let(:group_organization) { GroupOrganization.create!(name: "PLGroupOrganization1", organization_code: "PLGroupOrg1", country_id: country.id) }
    let(:token) {APIKey.create!}


    describe "authorization" do
      it "should return unauthorized HTTP 401 without token" do
        post :model_type_prices, id: group_organization.id,  model_type_name: "Service", base_price: 123,  format: :json

        expect(response).to_not be_success
        expect(response).to have_http_status(401)
      end

      it "responds successfully with an HTTP 200 status" do
        post :model_type_prices, id: group_organization.id,  model_type_name: "Service", base_price: 123, access_token: token.access_token,  format: :json

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    describe "testing types" do

      describe "correct values" do

        it "responds with calculated price for type Service" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Service', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Service", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(response.body).to include('price')
        end

        it "responds with calculated price for type Show room" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Show room', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Show room", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(response.body).to include('price')
        end

        it "responds with calculated price for type Dealer" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Dealer', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Dealer", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(response.body).to include('price')
        end
      end

      describe "incorrect values" do

        it "responds without price for type Service" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Dealer', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Service", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(response.body).to_not include('price')
        end

        it "responds without price for type Show room" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Service', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Show room", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(response.body).to_not include('price')
        end

        it "responds without price for type Dealer" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Show room', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Dealer", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(response.body).to_not include('price')
        end
      end
    end

    describe "testing pricing policy" do

      describe "correct values" do

        it "responds with calculated price Flexible pricing policy" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Service', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Service", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(JSON.parse(response.body)["organizations"][0]["price"].to_d).to be > 0
        end

        it "responds with calculated price Fixed pricing policy" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Show room', pricing_policy: 'Fixed', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Show room", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(JSON.parse(response.body)["organizations"][0]["price"].to_d).to be > 0
        end

        it "responds with calculated price Prestige pricing policy" do
          # if added it as let it doesn't exist n the db
          Organization.create!(name: 'PLOrganization1', org_type: 'Dealer', pricing_policy: 'Prestige', group_organization_id: group_organization.id)

          post :model_type_prices, id: group_organization.id,  model_type_name: "Dealer", base_price: 123, access_token: token.access_token,  format: :json

          expect(response).to be_success
          expect(JSON.parse(response.body)["organizations"][0]["price"].to_d).to be > 0
        end
      end
    end
  end

end
