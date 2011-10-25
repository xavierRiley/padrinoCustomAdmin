class CreateMusicians < ActiveRecord::Migration
  def self.up
    create_table :musicians do |t|
      t.string :title
      t.string :profile_img
    end
  end

  def self.down
    drop_table :musicians
  end
end
