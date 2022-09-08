class UrlsController < ActionController::Base
	def show
		full_url = UrlLookupService.new(params[:shortened]).call
		if full_url.present?
			redirect_to full_url, status: :moved_permanently, allow_other_host: true
		else
			raise ActiveRecord::RecordNotFound
		end
	end
end
