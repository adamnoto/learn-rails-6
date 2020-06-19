class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :locale, null: false
      t.st_point :coordinate,
        geographic: true,
        has_z: true,
        null: false
      t.string :name, null: false
      t.string :place_type, null: false

      t.timestamps
    end

    add_index :places, :locale
    add_index :places, :coordinate, using: :gist
    add_index :places, [:locale, :coordinate], unique: true
  end
end
