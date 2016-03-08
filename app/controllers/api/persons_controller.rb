class Api::PersonsController < ApplicationController



  def index
    @persons = Person.all
    render json: @persons.as_json
  end

  def update
    @person = Person.find_by(id: params[:id])
    if @person && @person.update(allow_params)
      render json: @person, status: :updated
    else
      render json: @person, status: :unprocessable_entity
    end
  end

  def create
    @person = Person.new(allow_params)
    if @person.save
      render json: @person, status: :created
    else
      render json: @person, status: :unprocessable_entity
    end
  end

  def destroy
    @person = Person.find_by(id: params[:id])
    if @person && @person.destroy
        render json: @person, status: :ok
    else
      render json: @person, status: :unprocessable_entity
    end
  end

  private

  def allow_params
    params.permit :first_name, :last_name, :birth_date
  end
end