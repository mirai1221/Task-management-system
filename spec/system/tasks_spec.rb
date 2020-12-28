require 'rails_helper'

describe 'タスク管理機能', type: :system do
  let(:user_a) do
    FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
  end
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) do
    FactoryBot.create(:task, name: '最初のタスク', user: user_a)
  end

  before do
    # ログイン部分の共通化
    visit login_path
    fill_in 'メールアドレス', with: login_user.email # context内の:login_userから引用する
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do # itの共通化
    it { expect(page).to have_content '最初のタスク' } # 作成済みのタスクの名称が画面上に表示されていることを確認
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a } # ログイン共通部分で使われる為に定義している
      it_behaves_like 'ユーザーAが作成したタスクが表示される' # shared_examples_forを呼び出している
    end

    context 'ユーザBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク' # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in '名称', with: task_name # contextのlet(:task_nameを引用している)
      click_button '登録する'
    end

    context '新規作成画面で名称を入力したとき' do
      let(:task_name) { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかったとき' do
      let(:task_name) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end
end
