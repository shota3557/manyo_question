class ChangeColumnToDefaultToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :priority, from: nil, to: 0
  end
end
