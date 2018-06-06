require 'rails_helper'

RSpec.describe 'credentials/edit', type: :view do
  before do
    @credential = assign(:credential, create(:credential))
  end

  it 'renders the edit credential form' do
    render

    assert_select 'form[action=?][method=?]', credential_path(@credential), 'post' do
      assert_select 'input[name=?]', 'credential[username]'
      assert_select 'input[name=?]', 'credential[apikey]'
    end
  end
end
