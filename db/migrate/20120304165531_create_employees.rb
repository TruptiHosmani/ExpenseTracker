class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.date :dob
      t.references :department
      t.references :job_title
      t.integer :manager_id

      t.timestamps
    end
    add_index :employees, :department_id
    add_index :employees, :job_title_id
    add_index :employees, :manager_id
  end
end
