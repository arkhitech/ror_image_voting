class AddNameAndUsernameAndProfilePictureAndDescriptionAndIsPrivateToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :profile_picture, :string
    add_column :users, :description, :string, limit: 140
    add_column :users, :is_private, :boolean
  end
end
