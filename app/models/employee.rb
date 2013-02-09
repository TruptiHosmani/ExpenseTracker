class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable,  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me ,:name, :dob, :department_id, :job_title_id, :manager_id
  belongs_to :department
  belongs_to :job_title
  belongs_to :manager, :class_name => "Employee"
  has_many :subordinates, :class_name => "Employee",  :foreign_key => "manager_id"
  has_many :expenses


end
