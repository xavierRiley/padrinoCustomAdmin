class CreateAdminConfigurations < ActiveRecord::Migration
  def self.up
    create_table :admin_configurations do |t|
      t.string :model_name
      t.string :fieldset
      t.text :contains
      t.boolean :hide
      t.string :label
      t.string :validation
    end
  end

  def self.down
    drop_table :admin_configurations
  end
end
