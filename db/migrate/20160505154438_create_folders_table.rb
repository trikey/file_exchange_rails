class CreateFoldersTable < ActiveRecord::Migration
  def change
    create_table :folders do |t|
			t.string :name
			t.string :description, null: true, default: :null
			t.integer :parent_id, null: true, default: :null
			t.timestamps null:true
    end
    add_index :folders, :parent_id
  end
end
