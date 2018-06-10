require 'api/coolpay/models/recipient'

class RecipientsController < ApplicationController
  before_action :authenticate

  # GET /recipients
  def index
    @recipients = Api::Coolpay::Models::Recipient.all(token)
  end

  # GET /recipients/new
  def new; end

  # POST /recipients
  def create
    @recipient = Api::Coolpay::Models::Recipient.new(token, recipient_params)

    respond_to do |format|
      if @recipient.save
        format.html { redirect_to recipients_path, notice: 'Recipient was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def recipient_params
    params.permit(:name)
  end
end
