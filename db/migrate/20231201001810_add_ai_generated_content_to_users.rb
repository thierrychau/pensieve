class AddAiGeneratedContentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :ai_generated_content, :boolean, default: false, null: false
  end
end
