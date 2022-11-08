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
        expect(page).to have_content 'のページ'
      end
    end

    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(current_path).to eq new_session_path
        expect(current_path).not_to eq tasks_path
      end
    end
  end

  describe 'ログイン機能' do
    context '登録済みのユーザでログインした場合' do
      it 'ログインし、マイページに飛べること' do
        FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'test@test.com'
        fill_in "session[password]", with: 'testtest'
        click_button 'ログインする'
        expect(page).to have_content 'タスクの状況'
      end
      
      it '自分の詳細画面にアクセスできる' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'test@test.com'
        fill_in "session[password]", with: 'testtest'
        click_button 'ログインする'
        expect(page).to have_content 'のページ'
      end
      
      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        user = FactoryBot.create(:user)
        user2 = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in "session[email]", with: 'test@test.com'
        fill_in "session[password]", with: 'testtest'
        click_button 'ログインする'
        visit user_path(user2.id)
        expect(page).to have_content '投稿一覧'
      end
      
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'test@test.com'
        fill_in "session[password]", with: 'testtest'
        click_button 'ログインする'
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン画面'
      end
    end
  end
  describe '管理者機能' do
    context '管理者がログインした場合' do
      it '管理雨せ画面にアクセスできる' do
        user = FactoryBot.create(:user)
        visit new_session_path
        fill_in "session[email]", with: 'test@test.com'
        fill_in "session[password]", with: 'testtest'
        click_button 'ログインする'
        click_on '管理者ページへ'
        expect(page).to have_content 'ユーザ一覧'
      end
      
      context '一般ユーザがユーザ一覧画面にアクセスした場合' do
        it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
          user = FactoryBot.create(:user)
          visit new_session_path
          fill_in "session[email]", with: 'test@test.com'
          fill_in "session[password]", with: 'testtest'
          click_button 'ログインする'
          click_on '管理者ページへ'
          expect(page).to have_content 'ユーザ一覧'
        end
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
    
    
  end
end