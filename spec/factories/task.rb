FactoryBot.define do
    # 作成するテストデータの名前を「task」とします
    # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
    factory :task do
      name { 'テスト１' }
      content { '内容１' }
      end_date { '002022-11-10' }
      status { '完成' }
      priority { '高い' }
    end
    # 作成するテストデータの名前を「second_task」とします
    # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    factory :second_task, class: Task do
      name  { 'テスト２' }
      content { '内容２' }
      end_date { '002022-11-11' }
      status { '未着手' }
      priority { '低い' }

      association :user
    end
  end