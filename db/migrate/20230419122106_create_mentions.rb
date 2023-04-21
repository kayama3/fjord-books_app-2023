class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      
      t.timestamps
      t.integer :mentioning_report_id, null: false
      t.integer :mentioned_report_id, null: false
    end
  end
end
