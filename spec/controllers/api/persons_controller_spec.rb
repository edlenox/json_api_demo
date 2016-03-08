require 'rails_helper'

describe Api::PersonsController do



  describe "GET index" do
    let!(:person){ FactoryGirl.create :person}

    it "assigns @persons" do
      get :index
      expect(assigns(:persons)).to eq([person])
    end

     it "renders the people as json" do
       get :index
       expect(response.body).to eq([person].to_json)
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




 end
