require 'api/coolpay/models/payment'

class PaymentsController < ApplicationController
  before_action :authenticate

  # GET /payments
  def index
    @payments = Api::Coolpay::Models::Payment.all(token)
  end

  # GET /payments/new
  def new
    @recipients = Api::Coolpay::Models::Recipient.all(token)
  end

  # POST /payments
  def create
    @payment = Api::Coolpay::Models::Payment.new(token, payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payments_path, notice: 'payment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def payment_params
    params.permit(:amount, :currency, :recipient_id)
  end
end
