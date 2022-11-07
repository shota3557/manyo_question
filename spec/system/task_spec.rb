require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    task = FactoryBot.create(:task)
    second_task = FactoryBot.create(:second_task)
  end

  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user, name: 'テスト', email: "test@test.com", password: "testtest", password_confirmation: "testtest") }
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task[name]", with: '名前1'
        fill_in "task[content]", with: '内容1'
        fill_in "task[end_date]", with: "002020-11-11"
        select '未着手', from: 'task[status]'
        select '高い', from: 'task[priority]'
        click_button '投稿する'
        expect(page).to have_content '名前1'
        expect(page).to have_content '内容1'
        expect(page).to have_content '2020-11-11'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高い'
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

    context '終了期限の近い順にした場合' do
      it '終了期限の近いタスクが一番上に表示される' do
        visit tasks_path
        click_link '期限順'
        sleep(2)
        task_list = all('tbody tr')
        expect(task_list[0]).to have_content 'テスト１'
        expect(task_list[1]).to have_content '内容２'
      end
    end 
  end

  context 'タイトル検索した場合' do
    it 'タイトル検索したものが表示される' do
      visit tasks_path
      fill_in "task[name]", with: "テスト１"
      click_button '検索する'
      task_list = all('tbody tr')
      expect(task_list[0]).to have_content 'テスト１'
    end
  end 

  context 'ステータス検索した場合' do
    it 'ステータス検索したものが表示される' do
      visit tasks_path
      select '完成', from: 'status[name]'
      click_button '検索する'
      task_list = all('tbody tr')
      expect(task_list[0]).to have_content '完成'
    end
  end

  context 'タイトルとステータス両方で検索した場合' do
    it 'タイトルとステータス両方で検索したものが表示される' do
      visit tasks_path
      fill_in "task[name]", with: "テスト２"
      select '未着手', from: 'status[name]'
      click_button '検索する'
      task_list = all('tbody tr')
      expect(task_list[0]).to have_content 'テスト２'
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