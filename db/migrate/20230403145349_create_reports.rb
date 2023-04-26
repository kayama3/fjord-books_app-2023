class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title, null: false
      t.string :body, null: false

      t.timestamps
      t.belongs_to :user, index: true, foreign_key: true, null: false
    end
  end
end
