class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.references :commentable, polymorphic: true, null: false
      t.timestamps
      t.belongs_to :user, index: true, foreign_key: true, null: false
    end
  end
end
