class UrlLookupService
  def initialize(shortened)
    @shortened = shortened
  end

  def call
    full_url = (cache_service.read || fetch_from_db).tap do |full_url|
      cache_service.write(full_url)
    end
  end

  private

  attr_reader :shortened

  def cache_service
    @cache_service ||= UrlCacheService.new(shortened)
  end

  def fetch_from_db
    Url.where(shortened: shortened).first&.full_url
  end
end
