class CreateFilesTable < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
			t.string :description, null: true, default: :null
			t.string :file
			t.integer :folder_id, null: true, default: :null
			t.timestamps null:true
    end
    add_index :upload_files, :folder_id
  end
end
