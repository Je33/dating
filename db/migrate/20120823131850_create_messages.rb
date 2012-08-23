class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text :text
      t.integer :user_to

      t.timestamps
    end
  end
end
