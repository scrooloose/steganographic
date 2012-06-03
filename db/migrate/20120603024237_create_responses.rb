class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :attempts
      t.integer :user_id
      t.integer :challenge_id

      t.timestamps
    end
  end
end
