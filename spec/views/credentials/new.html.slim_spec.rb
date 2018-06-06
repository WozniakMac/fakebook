require 'rails_helper'

RSpec.describe 'credentials/new', type: :view do
  before do
    assign(:credential, Credential.new(
                          username: 'MyString',
                          apikey: 'MyString'
    ))
  end

  it 'renders new credential form' do
    render

    assert_select 'form[action=?][method=?]', credentials_path, 'post' do
      assert_select 'input[name=?]', 'credential[username]'
      assert_select 'input[name=?]', 'credential[apikey]'
    end
  end
end
