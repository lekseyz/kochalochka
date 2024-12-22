  class CreateUsers < ActiveRecord::Migration[6.0]
    def change
      create_table :users do |t|
        t.string :username
        t.string :password_digest
        t.integer :weight
        t.integer :height
        t.date :birth_day
        t.string :goal
        t.string :sex

        t.timestamps
      end
    end
  end
