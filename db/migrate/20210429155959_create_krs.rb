class CreateKrs < ActiveRecord::Migration[6.1]
  def change
    create_table :krs do |t|
      t.integer :objectif_id
      t.string :title
      t.integer :weight

      t.timestamps
    end
  end
end
