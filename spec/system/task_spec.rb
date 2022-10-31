require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    task = FactoryBot.create(:task)
    second_task = FactoryBot.create(:second_task)
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_name", with: '名前1'
        fill_in "task_content", with: '内容1'
        click_button '投稿する'
        expect(page).to have_content '名前1'
        expect(page).to have_content '内容1'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content '内容'
      end
    end

    context '作成日時順にした場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_lists = all('tbody tr')
        expect(task_lists[0]).to have_content 'テスト２'
        expect(task_lists[1]).to have_content '内容１'
      end
    end  
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task.id)
        expect(page).to have_content 'テスト'
      end
    end
  end
end