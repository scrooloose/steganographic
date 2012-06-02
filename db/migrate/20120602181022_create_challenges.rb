class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :image_1_id
      t.integer :image_2_id
      t.text :clue

      t.timestamps
    end
  end
end
