class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :hash_password
      t.integer :weight
      t.integer :height
      t.date :birth_day
      t.string :goal
      t.string :sex

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
