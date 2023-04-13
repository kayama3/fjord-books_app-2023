class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :commentable, polymorphic: true
      t.timestamps
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
