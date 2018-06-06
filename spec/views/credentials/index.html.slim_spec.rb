require 'rails_helper'

RSpec.describe 'credentials/index', type: :view do
  let(:user) { create(:user) }

  before do
    assign(:credentials, [
             Credential.create!(
               username: 'Username',
               apikey: 'Apikey',
               user: user
             ),
             Credential.create!(
               username: 'Username',
               apikey: 'Apikey',
               user: user
             )
           ])
  end

  it 'renders a list of credentials' do
    render
    assert_select 'tr>td', text: 'Username'.to_s, count: 2
    assert_select 'tr>td', text: '******'.to_s, count: 2
  end
end
