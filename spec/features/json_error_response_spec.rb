require 'rails_helper'

describe "API error", :type => :request do
  it 'responds with json if incorrect route' do
    get '/api/gobbledygook'
    json = JSON.parse(response.body)
    expect(response).to have_http_status(:error)
  end
end
