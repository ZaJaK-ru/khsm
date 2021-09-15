require 'rails_helper'

RSpec.feature 'USER views profile another user', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:user) }
  let!(:games) do
    [
      FactoryBot.create(:game, user: another_user, created_at: '15.09.2021 09:50:10', current_level: 1, prize: 100),
      FactoryBot.create(:game, user: another_user, current_level: 3, prize: 300)
    ]
  end

  before(:each) do
    login_as user
  end

  scenario 'success' do
    visit '/'

    click_link another_user.name

    expect(page).not_to have_content('Сменить имя и пароль')
    expect(page).to have_content(another_user.name)
    expect(page).to have_content 'в процессе'
    expect(page).to have_content('15 сент., 09:50')
    expect(page).to have_text(I18n.l(games[1].created_at, format: :short))
    expect(page).to have_content('100 ₽')
    expect(page).to have_content('300 ₽')
    expect(page).to have_content('50/50')
    expect(page).to have_css('.fa-phone')
    expect(page).to have_css('.fa-users')

    save_and_open_page
  end
end
