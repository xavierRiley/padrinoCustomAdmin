class AddPositionToMusicians < ActiveRecord::Migration
  def self.up
    change_table :musicians do |t|
      t.integer :position
    end
  end

  def self.down
    change_table :musicians do |t|
      t.remove :position
    end
  end
end
