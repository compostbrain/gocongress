class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :name
      t.string :aga_id
      t.string :club
      t.string :country
      t.string :rank
      t.string :rating

      t.timestamps
    end
  end
end
