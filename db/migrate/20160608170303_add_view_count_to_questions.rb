class AddViewCountToQuestions < ActiveRecord::Migration
  def change
      add_column :questions, :view_count, :integer
  end
end
