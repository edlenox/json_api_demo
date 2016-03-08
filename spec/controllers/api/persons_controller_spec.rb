require 'rails_helper'

describe Api::PersonsController do
  describe "GET index" do
      it "assigns @persons" do
        person = FactoryGirl.create :person
        get :index
        expect(assigns(:persons)).to eq([person])
      end

      # it "renders the index template" do
      #   get :index
      #   expect(response).to render_template("index")
      # end
    end
 end
