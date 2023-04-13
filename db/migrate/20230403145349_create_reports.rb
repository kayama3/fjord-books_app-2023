class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :body

      t.timestamps
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
