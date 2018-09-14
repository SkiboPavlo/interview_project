class PhonesController < ApplicationController
  before_action :set_phone, only: %i[show update destroy]

  def index
    @phones = Phone.all

    render json: @phones
  end

  def show
    render json: @phone
  end

  def create
    @phone = Phone.new(phone_params)

    if @phone.save
      check_number
      render json: @phone, status: :created, location: @phone
    else
      render json: @phone.errors, status: :unprocessable_entity
    end
  end

  def update
    if @phone.update(phone_params)
      render json: @phone
    else
      render json: @phone.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @phone.destroy
  end

  private

  def check_number
    if @phone.phone_num.blank?
      num = rand(1_111_111_111...9_999_999_999).to_s
      phone = num.slice(0,3) + '-' + num.slice(3..5) + '-' + num.slice(6..10)
      @phone.phone_num = phone unless exist_number?(phone)
    end
    @phone.save
  end

  def exist_number?(phone)
    Phone.exists?(phone_num: phone)
  end

  def set_phone
    @phone = Phone.find(params[:id])
  end

  def phone_params
    params.permit(:phone_num)
  end
end
