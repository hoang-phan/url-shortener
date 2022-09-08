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

    def create
      @url = Url.new(url_params)
      UrlBuilder.new(@url).build

      if @url.save
        UrlCacheService.new(@url.shortened).write(@url.full_url)
        render :show, status: :created
      else
        render json: @url.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @url.destroy
      UrlCacheService.new(@url.shortened).write(@url.full_url)
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