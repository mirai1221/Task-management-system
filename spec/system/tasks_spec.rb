require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') } # ユーザーAを作成しuser_aに入れる :userでデータ内容がusers.rbのデータ内容になっている
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
    before do
      FactoryBot.create(:task, name: '最初のタスク', user: user_a) # 作成者がuser_aであるタスクを作成する
      #ログイン部分の共通化
      visit login_path
      fill_in 'メールアドレス', with: login_user.email # context内の:login_userから引用する
      fill_in 'パスワード', with: login_user.password
      click_button 'ログイン'
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) {user_a} #ログイン共通部分で使われる為に定義している
      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク' # 作成済みのタスクの名称が画面上に表示されていることを確認
      end
    end

    context 'ユーザBがログインしているとき' do
      let(:login_user) {user_b}

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'  #ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
      end
    end
  end
end
