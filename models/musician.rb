require 'carrierwave/orm/activerecord'
class Musician < ActiveRecord::Base
  scope :published, lambda { where("publish = ?", true).order("position ASC") }

   mount_uploader :profile_img, Uploader
  validates_uniqueness_of :position
  acts_as_list :order => "position"
  after_create :initialize_position

  private
  def initialize_position
    self.position = musician.maximum(:position) + 1
  end
end
