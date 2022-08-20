class TenantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_tenant_error
rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    def index
        tenants = Tenant.all 
        render json: tenants
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created  
    end

    def update 
        tenant = Tenant.find(params[:id])
        tenant.update!(tenant_params)
        render json: tenant, status: :created
    end

    def destroy 
        tenant = Tenant.find(params[:id])
        tenant.destroy 
        head :no_content
    end

    private 

    def render_tenant_error 
        render json: {error: "Tenant Not Found"}, status: :not_found
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def unprocessable_entity(valid)
        render json: { error: valid.record.errors }, status: :unprocessable_entity
    end
end
