require 'rails_helper'

RSpec.describe API::V1::OrganizationsController, :type => :controller do
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

    describe "returns all orgs" do
      it "responds with uniq id and name" do
        org1 = Organization.create!(name: 'PLOrganization1', org_type: 'Service', pricing_policy: 'Flexible', group_organization_id: group_organization.id)
        org1 = Organization.create!(name: 'PLOrganization2', org_type: 'Service', pricing_policy: 'Flexible', group_organization_id: group_organization.id)
        org1 = Organization.create!(name: 'PLOrganization3', org_type: 'Service', pricing_policy: 'Flexible', group_organization_id: group_organization.id)

        get :show, id: group_organization.id, access_token: token.access_token,  format: :json

        expect(response.body).to include("PLOrganization1")
        expect(response.body).to include("PLOrganization2")
        expect(response.body).to include("PLOrganization3")
      end
    end

  end
end
