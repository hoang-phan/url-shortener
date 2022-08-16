module V1
  class UrlsController < ApplicationController
    before_action :set_url, only: %i[ show edit update destroy ]

    def index
      @urls = Url.all
    end

    def show
    end

    def new
      @url = Url.new
    end

    def edit
    end

    def create
      @url = Url.new(url_params)

      if @url.save
        render :show, status: :created
      else
        render json: @url.errors, status: :unprocessable_entity
      end
    end

    def update
      if @url.update(url_params)
        render :show, status: :ok
      else
        render json: @url.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @url.destroy
      head :no_content
    end

    private

    def set_url
      @url = Url.find(params[:id])
    end

    def url_params
      params.require(:url).permit(:full_url, :datacenter_id)
    end
  end
end