class AddPublishToMusicians < ActiveRecord::Migration
  def self.up
    change_table :musicians do |t|
      t.boolean :publish
    end
  end

  def self.down
    change_table :musicians do |t|
      t.remove :publish
    end
  end
end
