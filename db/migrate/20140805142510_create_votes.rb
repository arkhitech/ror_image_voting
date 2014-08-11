class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote_status
      t.references :user, index: true
      t.references :slam, index: true

      t.timestamps
    end
  end
end
