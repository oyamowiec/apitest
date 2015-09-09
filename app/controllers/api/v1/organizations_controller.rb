module API
  module V1
    class API::V1::OrganizationsController < ApplicationController
      before_filter :restrict_access

      def show
        ids = params[:id].split(',')
        @group_organizations = GroupOrganization.where(id: ids)
        if @group_organization.present?
          @locations = @group_organization.locations
        end
        respond_to do |format|
          format.json { render 'api/v1/group_organizations/show_orgs' }
        end
      end
    end
  end
end
