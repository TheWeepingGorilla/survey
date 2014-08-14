class RenameResponseColumn < ActiveRecord::Migration
  def change
    rename_column(:responses, :answers_id, :answer_id)
  end
end
