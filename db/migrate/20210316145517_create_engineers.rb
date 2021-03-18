class CreateEngineers < ActiveRecord::Migration[6.1]
  def change
    create_table :engineers do |t|
      t.string :gh_nickname

      t.timestamps
    end
  end
end
