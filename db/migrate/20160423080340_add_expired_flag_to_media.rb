class AddExpiredFlagToMedia < ActiveRecord::Migration
  def change
    add_column :media, :expired, :boolean
  end
end
