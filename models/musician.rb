require 'carrierwave/orm/activerecord'
class Musician < ActiveRecord::Base

   mount_uploader :profile_img, Uploader
end
