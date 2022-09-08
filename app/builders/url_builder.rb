class UrlBuilder
  SEQUENCE_COUNT = 2 ** 10
  START_EPOCH = 1660389155985

  delegate :sequence_id, :datacenter_id, to: :url

  def initialize(url)
    @url = url
  end

  def build
    url.sequence_id = build_sequence_id
    url.shortened = build_shortened
  end

  private

  attr_reader :url

  def build_shortened
    shortened_bits = 0
    shortened_bits ^= epoch_time << 14
    shortened_bits ^= sequence_id << 4
    shortened_bits ^= datacenter_id

    IntToBase64.encode(shortened_bits)
  end

  def build_sequence_id
    sequence_id = (Rails.cache.read(sequence_id_cache_key).to_i + 1) % SEQUENCE_COUNT
    Rails.cache.write(sequence_id_cache_key, sequence_id, expires_in: 1.hour)
    sequence_id
  end

  def epoch_time
    (Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond) - START_EPOCH)
  end

  def sequence_id_cache_key
    "sequence_id_#{datacenter_id}"
  end
end
