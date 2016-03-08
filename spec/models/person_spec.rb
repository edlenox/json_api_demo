require 'rails_helper'

RSpec.describe Person, type: :model do

  it { is_expected.to respond_to(:first_name, :last_name, :birth_date) }
  it { is_expected.to respond_to(:age) }

  describe "Age Calculation" do
    let!(:person){FactoryGirl.create :person, birth_date: Date.parse('2010-01-03')}


    it "calculates age correctly" do
      Timecop.travel(Date.parse('2015-01-04'))
      expect(Person.first.age).to eq(5)
    end

    it "calculates age correctly" do
      Timecop.travel(Date.parse('2015-01-02'))
      expect(Person.first.age).to eq(4)
    end
  end



  describe "JSON rendering" do
    let!(:person){FactoryGirl.create :person}

    it "renders a person's age as JSON" do
      expect(person.as_json[:age]).to eq(person.age)
    end

    it "renders a person as JSON" do
      expect(person.as_json).to eq( {id: person.id,
                                      first_name: person.first_name,
                                      last_name: person.last_name,
                                      age: person.age})
    end

  end


end
