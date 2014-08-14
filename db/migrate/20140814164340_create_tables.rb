class CreateTables < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string   :name
    end
    create_table :questions do |t|
      t.integer  :survey_id
      t.string   :text
      t.integer  :type
    end
    create_table :answers do |t|
      t.integer  :question_id
      t.string   :text
      end
    create_table :logs do |t|
      t.integer  :survey_id
      t.integer  :question_id
      t.integer  :answer_id
    end
  end
end
