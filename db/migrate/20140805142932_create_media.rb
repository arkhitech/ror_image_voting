class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :picture
      t.string :caption, limit: 140
      t.boolean :is_private
      t.references :user, index: true

      t.timestamps
    end
  end
end
