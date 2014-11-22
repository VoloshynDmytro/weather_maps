class InsertRoleInUserModel < ActiveRecord::Migration
  def up
    add_column :users, :role, :integer, :null => false, default: 0

    Role.find_each do |role|
      # Since I've removed 'rolify' from the user model, I have to get down and
      # dirty with it in order to find out what each users' role was.
      ActiveRecord::Base.connection.execute(%{
        UPDATE users AS u
        SET role = #{role.id}
        FROM users_roles AS ur
        WHERE ur.role_id = #{role.id} AND ur.user_id = u.id
      })
    end

    drop_table :users_roles
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
