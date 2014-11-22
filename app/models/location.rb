class Location < ActiveRecord::Base
  belongs_to :user
  has_many :measurements

  accepts_nested_attributes_for :measurements
end
