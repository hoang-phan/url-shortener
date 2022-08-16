class UrlsController < ActionController::Base
	def show
		url = Url.where(shortened: params[:shortened]).first
		if url.present?
			redirect_to url.full_url, status: :moved_permanently, allow_other_host: true
		else
			raise ActiveRecord::RecordNotFound
		end
	end
end
