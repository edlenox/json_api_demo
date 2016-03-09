require 'rails_helper'

describe Api::PersonsController do

  before(:each) do

   allow(JokeService).to receive(:random_joke).and_return("joke")
  end

  describe "GET index" do
    let!(:person){ FactoryGirl.create :person}

    it "assigns @persons" do
      get :index
      expect(assigns(:persons)).to eq([person])
    end

     it "renders the people as json" do
       get :index
       expect(response.body).to eq([person].to_json(with_joke: true))
     end


     it "sorts results by parameter passed in" do
        person1 = FactoryGirl.create :person

     end
  end


  describe "GET index sorting" do
    let!(:person1){ FactoryGirl.create :person, first_name: 'Alan', last_name: 'Adder', birth_date: Date.parse('1970-01-01')}
    let!(:person2){ FactoryGirl.create :person, first_name: 'William', last_name: 'Wallace', birth_date: Date.parse('1980-01-01')}
    let!(:person3){ FactoryGirl.create :person, first_name: 'Harry', last_name: 'Yellow', birth_date: Date.parse('1975-01-01')}



     it "orders the people by first name" do
       first_person_by_first_name = FactoryGirl.create :person, first_name: 'AAA', last_name: 'Adder', birth_date: Date.parse('1970-01-01')
       get :index, {sort: 'first_name'}
       expect(assigns(:persons)).to eq([first_person_by_first_name, person1, person3, person2])
     end

     it "orders the people by last name" do
       first_person_by_last_name = FactoryGirl.create :person, first_name: 'zzz', last_name: 'AAA', birth_date: Date.parse('1970-01-01')
       get :index, {sort: 'last_name'}
       expect(assigns(:persons)).to eq([first_person_by_last_name, person1, person2, person3])
     end

     it "orders the people by age" do
       first_person_by_age = FactoryGirl.create :person, first_name: 'AAA', last_name: 'Adder', birth_date: Date.parse('1969-01-01')
       get :index, {sort: 'age'}
       expect(assigns(:persons)).to eq([first_person_by_age, person1, person3, person2])
     end

     it "doesn't order the people by age incorrectly" do
       first_person_by_age = FactoryGirl.create :person, first_name: 'AAA', last_name: 'Adder', birth_date: Date.parse('1969-01-01')
       get :index, {sort: 'age'}
       expect(assigns(:persons)).to_not eq([first_person_by_age, person1, person2, person3])
     end
  end


  describe "POST create" do

     it "creates a person" do
       post :create, FactoryGirl.attributes_for( :person)
       expect(Person.count).to eq(1)
     end

     it "responds with new person json" do
       post :create, FactoryGirl.attributes_for( :person)
       expect(response.body).to eq(Person.first.to_json)
     end

     it "returns 201 if successful" do
       post :create, FactoryGirl.attributes_for( :person)
       expect(response).to have_http_status(:created)
     end

     it "returns 422 if invalid params" do
       post :create, {}
       expect(response).to have_http_status(:unprocessable_entity)
     end

  end

  describe "POST update" do
    let!(:person){ FactoryGirl.create :person}

      it "updates a person" do
        put :update, {id: person.id, first_name: "joe"}
        expect(Person.first.first_name).to eq("joe")
        expect(response).to have_http_status(:ok)
      end

      it "returns 422 if person doesn't exist" do
       put :update, {id: -1, first_name: "joe"}
       expect(response).to have_http_status(:unprocessable_entity)
      end

   end


   describe "DELETE destroy" do
     let!(:person){ FactoryGirl.create :person}

       it "deletes a person" do
         delete :destroy, {id: person.id}
         expect(Person.count).to eq(0)
       end

       it "reponds with 200 when successful" do
         delete :destroy, {id: person.id}
         expect(response).to have_http_status(:ok)
       end

       it "returns 422 if person doesn't exist" do
         delete :destroy, {id: -1}
         expect(response).to have_http_status(:unprocessable_entity)
       end

    end

    describe "GET show" do
      let!(:person){ FactoryGirl.create :person}
      it "renders a person" do
        get :show, {id: person.id}
        expect(response.body).to eq(person.to_json(with_joke: true))
      end

      it "responds with 422 if not found" do
        get :show, {id: -1}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end




 end
