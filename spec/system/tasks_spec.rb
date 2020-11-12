require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') # ユーザーAを作成しておく :userでデータ内容がusers.rbのデータ内容になっている
      FactoryBot.create(:task, name: '最初のタスク', user: user_a) # 作成者がuser_aであるタスクを作成する
    end

    context 'ユーザーAがログインしているとき' do
      before do
        visit login_path # ユーザーAでログインする
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク' # 作成済みのタスクの名称が画面上に表示されていることを確認
      end
    end

    context 'ユーザBがログインしているとき' do
      before do
        FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') # ユーザーBを作成しておく
        visit login_path # ユーザーBでログインする
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'  #ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
      end
    end
  end
end
