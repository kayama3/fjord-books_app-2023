class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      
      t.timestamps

      t.integer :mentioning_report_id, null: false
      t.integer :mentioned_report_id, null: false
      t.index [:mentioning_report_id, :mentioned_report_id], unique:true
    end
    add_foreign_key :mentions, :reports, column: 'mentioning_report_id'
    add_foreign_key :mentions, :reports, column: 'mentioned_report_id'
  end
end
