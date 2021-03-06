class AddAttachmentReceiptImageToExpense < ActiveRecord::Migration
  def self.up
    change_table :expenses do |t|
      t.has_attached_file :receipt
    end
  end

  def self.down
    drop_attached_file :employees, :receipt
  end
end
