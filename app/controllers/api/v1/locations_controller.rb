module API
  module V1
    class API::V1::LocationsController < ApplicationController
      before_filter :restrict_access

      def show
        @group_organization = GroupOrganization.where(id: params[:id]).first
        respond_to do |format|
          format.json { render 'api/v1/group_organizations/show' }
        end
      end

    end
  end
end
