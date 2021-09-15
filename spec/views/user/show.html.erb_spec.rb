require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { assign(:user, FactoryBot.create(:user, name: 'Vova')) }

  before(:each) do
    user
    assign(:games, FactoryBot.build_stubbed_list(:game, 3))

    render
  end

  it 'renders player name' do
    expect(rendered).to match 'Vova'
  end

  it 'renders games' do
    expect(rendered).to match 'в процессе'
  end

  context 'when the user is not logged in' do
    it 'do not render button to change password' do
      expect(rendered).not_to match 'Сменить имя и пароль'
    end
  end

  context 'when the user is logged in' do
    before(:each) do
      sign_in user

      render
    end

    it 'render button to change password' do
      expect(rendered).to match 'Сменить имя и пароль'
    end
  end
end
