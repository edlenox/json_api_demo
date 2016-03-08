require 'rails_helper'

RSpec.describe Person, type: :model do

  it { is_expected.to respond_to(:first_name, :last_name, :birth_date) }
end
