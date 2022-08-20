class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_apartment_error

    def index
        apartments = Apartment.all 
        render json: apartments
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment
    end

    def create 
        apartment = Apartment.create(apartment_params)
        render json: apartment, status: :created  
    end

    def update 
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment, status: :created
    end

    def destroy 
        apartment = Apartment.find(params[:id])
        apartment.destroy 
        head :no_content
    end

    private 

    def render_apartment_error 
        render json: {error: "Apartment Not Found"}, status: :not_found
    end

    def apartment_params
        params.permit(:number)
    end

end
