require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(name: '', content: '失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(name: '失敗テスト', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: 'テスト', content: '成功する')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    let!(:task) { FactoryBot.create(:task, name: 'テスト１', status: "完成") }
    let!(:second_task) { FactoryBot.create(:second_task, name: "てすと２", status: "未着手" ) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.task_name('テスト')).to include(task)
        expect(Task.task_name('テスト')).not_to include(second_task)
        expect(Task.task_name('テスト').count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_name('完成')).to include(task)
        expect(Task.status_name('完成')).not_to include(second_task)
        expect(Task.status_name('完成').count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.task_name('テスト') && Task.status_name('完成')).to include(task)
        expect(Task.task_name('テスト') && Task.status_name('完成')).not_to include(second_task)
        expect(Task.task_name('テスト') && Task.status_name('完成').count).to eq 1
      end
    end
  end
end
