class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :fio
    	t.string :email
    	t.string :password
    	t.string :organisation
		t.integer :isAdmin, :unsigned_integer, null: true, default: :null
		t.integer :isModerator, :unsigned_integer, null: true, default: :null
		t.integer :canAccess, :unsigned_integer, null: true, default: :null
		t.string :rememberToken, null: true
        t.string :salt
    	t.timestamps null:true
    end
    add_index :users, :email, :unique => true
  end
end
