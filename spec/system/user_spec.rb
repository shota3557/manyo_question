require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe '登録機能' do
    context 'ユーザを登録した場合' do
      it '新規登録ができる' do
        user = FactoryBot.create(:user)
        visit new_user_path
        fill_in "user[name]", with: 'テスト'
        fill_in "user[email]", with: 'test100@test.com'
        fill_in "user[password]", with: "testtest"
        fill_in "user[password_confirmation]", with: "testtest"
        click_button '登録する'
        expect(page).to eq user_path(user.id)
      end
    end

    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to eq new_session_path
      end
    end
  end

  describe 'ログイン機能' do
    context '登録済みのユーザでログインした場合' do
      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
      
      end
      
      it '自分の詳細画面にアクセスできる' do
      
      end
      
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
      
      end
      
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
      
      end
    end
  end
  describe '管理者機能' do
    context '管理者がログインした場合' do
      it 'ユーザ一覧画面にアクセスできる' do
      
      end
      
      it '管理者を登録できる' do
      
      end
      
      it 'ユーザ詳細画面にアクセスできる' do
      
      end
      
      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do
      
      end
      
      it 'ユーザを削除できる' do
      
      end
    end
    
    context '一般ユーザがユーザ一覧画面にアクセスした場合' do
      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
      
      end
    end
  end
end