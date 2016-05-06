class CreateFilesTable < ActiveRecord::Migration
  def change
    create_table :files do |t|
			t.string :name
			t.string :description, null: true, default: :null
			t.string :path
			t.integer :folder_id, null: true, default: :null
			t.timestamps null:true
    end
    add_index :files, :folder_id
  end
end
