class Api::PersonsController < ApplicationController

  def index
    sort_param = case params[:sort]
    when 'age'
      :birth_date
    when 'first_name'
      "lower(first_name)"
    when 'last_name'
      "lower(last_name)"
    else
      :id
    end

    @persons = Person.all.order(sort_param)
    render json: @persons.as_json(with_joke: true)
  end


  def show
    @person = Person.find_by(id: params[:id])
    if @person
      render json: @person.as_json(with_joke: true)
    else
      render json: @person, status: :unprocessable_entity
    end
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
