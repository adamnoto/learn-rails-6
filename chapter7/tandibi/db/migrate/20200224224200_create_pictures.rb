class CreatePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.string :caption
      t.bigint :post_id, null: false

      t.timestamps
    end

    add_foreign_key :pictures, :posts
  end
end
