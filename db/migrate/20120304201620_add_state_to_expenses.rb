class AddStateToExpenses < ActiveRecord::Migration
  def change
  change_table :expenses do |t|
    t.references :expense_state
  end
  end
end
