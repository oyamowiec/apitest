module API
  module V1
    class API::V1::GroupOrganizationsController < ApplicationController
      before_filter :restrict_access
      skip_before_filter  :verify_authenticity_token

      def model_type_prices
        @group_organization = GroupOrganization.where(id: params[:id]).first
        @organizations = Organization.where(group_organization: @group_organization.id).where(org_type:  params[:model_type_name])
        if @organizations.first.present?
          @organizations.first.init_pricing(params[:base_price])
        end

        respond_to do |format|
          format.json { render 'api/v1/group_organizations/model_type_prices'}
        end
      end

      private
      
      def organization_params
        params.permit('model_type_name', 'base_price')
      end
    end
  end
end
