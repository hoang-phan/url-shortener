class Url
  include Mongoid::Document
  include Mongoid::Timestamps
  field :full_url, type: String
  field :shortened, type: String
  field :datacenter_id, type: Integer
  field :sequence_id, type: Integer

  before_save :set_sequence_id
  before_save :set_shortened

  START_EPOCH = 1660389155985
  SEQUENCE_COUNT = 2 ** 10

  private

  def set_sequence_id
    cache_key = "sequence_id_#{datacenter_id}"
    self.sequence_id = (Rails.cache.read("sequence_id_#{datacenter_id}").to_i + 1) % SEQUENCE_COUNT
    Rails.cache.write("sequence_id_#{datacenter_id}", sequence_id, expires_in: 1.hour)
  end

  def set_shortened
    shortened_bits = 0
    shortened_bits ^= epoch_time << 14
    shortened_bits ^= sequence_id << 4
    shortened_bits ^= datacenter_id

    self.shortened = IntToBase64.encode(shortened_bits)
  end


  def epoch_time
    (Process.clock_gettime(Process::CLOCK_REALTIME, :millisecond) - START_EPOCH)
  end
end
