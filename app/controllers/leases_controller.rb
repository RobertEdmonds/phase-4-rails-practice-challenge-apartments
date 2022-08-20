class LeasesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_lease_error

    def create 
        lease = Lease.create(lease_params)
        render json: lease, status: :created  
    end

    def destroy 
        lease = Lease.find(params[:id])
        lease.destroy 
        head :no_content
    end

    private 

    def render_lease_error 
        render json: {error: "Lease Not Found"}, status: :not_found
    end

    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end

end
