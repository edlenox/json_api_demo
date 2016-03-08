class Person < ActiveRecord::Base

  validates :first_name, :last_name, :birth_date, presence: true

  def age
    return nil unless birth_date
    now = Date.current
    years_since_birth = now.year - birth_date.year
    years_since_birth -= 1 if now.yday < birth_date.yday
    years_since_birth
  end


  def as_json(options={})
    {id: id, first_name: first_name, last_name: last_name, age: age}
  end

end
