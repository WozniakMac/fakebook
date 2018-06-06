require 'rails_helper'

RSpec.describe 'credentials/show', type: :view do
  let(:user) { create(:user) }

  before do
    @credential = assign(:credential, Credential.create!(
                                        username: 'Username',
                                        apikey: 'Apikey',
                                        user: user
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Apikey/)
  end
end
