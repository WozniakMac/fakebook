require 'api/coolpay/authentication'

class CredentialsController < ApplicationController
  before_action :set_credential, only: [:show, :edit, :update, :destroy, :verify]
  before_action :authenticate
  before_action :validate_credential_author, only: [:show, :edit, :update, :destroy, :verify]
  before_action :validate_credentials_limit, only: [:create, :new]

  # GET /credentials
  def index
    @credentials = current_user.credentials
  end

  # GET /credentials/1
  def show; end

  # GET /credentials/new
  def new
    @credential = Credential.new
  end

  # GET /credentials/1/edit
  def edit; end

  # POST /credentials
  def create
    @credential = Credential.new(credential_params)
    @credential.user = current_user

    respond_to do |format|
      if @credential.save
        format.html { redirect_to @credential, notice: 'Credential was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /credentials/1
  def update
    respond_to do |format|
      if @credential.update(credential_params)
        format.html { redirect_to @credential, notice: 'Credential was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /credentials/1
  def destroy
    @credential.destroy
    respond_to do |format|
      format.html { redirect_to credentials_url, notice: 'Credential was successfully destroyed.' }
    end
  end

  # POST /credentials/1/verify
  def verify
    body = Api::Coolpay::Authentication.login(@credential.username, @credential.apikey)
    respond_to do |format|
      if body['error'].present?
        format.html { redirect_to @credential, notice: body['error'] }
      else
        format.html { redirect_to @credential, notice: 'Credential was successfully testes.' }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_credential
    @credential = Credential.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def credential_params
    params.require(:credential).permit(:username, :apikey)
  end

  def validate_credential_author
    validate_author(@credential)
  end

  def validate_credentials_limit
    Credential.count.positive? && redirect_back(
      fallback_location: root_path,
      notice: 'Cannot create more than one crenedtial.'
    )
  end
end
