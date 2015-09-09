require 'rails_helper'

RSpec.describe API::V1::LocationsController, :type => :controller do
  render_views

  describe "GET #show" do

    let(:country) { Country.create!(name: 'Polska', country_code: "PL") }
    let(:group_organization) { GroupOrganization.create!(name: "PLGroupOrganization1", organization_code: "PLGroupOrg1", country_id: country.id) }
    let(:token) {APIKey.create!}


    describe "authorization" do
      it "should return unauthorized HTTP 401 without token" do
        get :show, id: group_organization.id,  format: :json

        expect(response).to_not be_success
        expect(response).to have_http_status(401)
      end

      it "responds successfully with an HTTP 200 status" do
        get :show, id: group_organization.id, access_token: token.access_token,  format: :json

        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    describe "returns names of all locations" do
      it "responds with all names by group organization" do
        org1 = Organization.create!(name: 'PLOrganization1', org_type: 'Service', pricing_policy: 'Flexible', group_organization_id: group_organization.id)
        Location.create!(name: 'address1', address: 'address', organization_id: org1.id)
        Location.create!(name: 'address2', address: 'address', organization_id: org1.id)

        get :show, id: group_organization.id, access_token: token.access_token,  format: :json

        expect(response.body).to include("address1")
        expect(response.body).to include("address2")
      end
    end

  end

end
