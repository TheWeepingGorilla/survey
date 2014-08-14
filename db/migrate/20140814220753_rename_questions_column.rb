class RenameQuestionsColumn < ActiveRecord::Migration
  def change
    rename_column(:questions, :type, :q_type)
  end
end
