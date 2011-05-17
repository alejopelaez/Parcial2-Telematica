class CreateBiDis < ActiveRecord::Migration
  def self.up
    create_table :bi_dis do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bi_dis
  end
end
