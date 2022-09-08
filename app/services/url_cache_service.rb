class UrlCacheService
  CACHE_PREFIX = 'url::'.freeze
  CACHE_DURATION = 1.hour

  def initialize(shortened)
    @shortened = shortened
  end

  def read
    Rails.cache.read(cache_key)
  end

  def write(full_url)
    Rails.cache.write(cache_key, full_url, expires_in: CACHE_DURATION) if full_url.present?
  end

  def delete
    Rails.cache.delete(cache_key)
  end

  private

  attr_reader :shortened

  def cache_key
    "#{CACHE_PREFIX}#{shortened}"
  end
end
