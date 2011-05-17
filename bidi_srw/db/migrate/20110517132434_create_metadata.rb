class CreateMetadata < ActiveRecord::Migration
  def self.up
    create_table :metadata do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :metadata
  end
end
