class RemoveReceiptFromExpenses < ActiveRecord::Migration
  def up
    remove_column :expenses, :receipt
  end

  def down
    add_column :expenses, :receipt
  end
end
