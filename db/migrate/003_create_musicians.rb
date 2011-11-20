class CreateMusicians < ActiveRecord::Migration
  def self.up
    create_table :musicians do |t|
      t.string :title
      t.string :instrument
      t.string :profile_img
      t.text :bio_mce
    end
  end

  def self.down
    drop_table :musicians
  end
end
