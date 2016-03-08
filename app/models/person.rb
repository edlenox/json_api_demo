class Person < ActiveRecord::Base

  validates :first_name, :last_name, :birth_date, presence: true
end
