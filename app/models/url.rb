class Url
  include Mongoid::Document
  include Mongoid::Timestamps

  field :full_url, type: String
  field :shortened, type: String
  field :datacenter_id, type: Integer
  field :sequence_id, type: Integer
end
