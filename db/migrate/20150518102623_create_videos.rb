class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :cover
      t.string :screenshot

      t.timestamps
    end
  end
end
