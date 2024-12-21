class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    unless table_exists?(:users)
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
    end
  end
end
