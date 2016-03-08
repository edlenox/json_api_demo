require 'rails_helper'

describe JokeService do
  it " gets a random_joke" do
    expect(JokeService.random_joke).to be_a(String)
  end

  it "inserts names into joke" do
    person = FactoryGirl.build :person
    expect(JokeService.random_joke(person)).to match(/#{person.first_name}/)
  end

  it "gives an error if joke api fails" do
    allow(HTTParty).to receive(:get).and_return(nil)
    expect(JokeService.random_joke).to eq("problem getting joke")
  end

end
