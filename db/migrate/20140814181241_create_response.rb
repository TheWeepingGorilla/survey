class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to :answers
    end
  end
end
