class AddNoteInfoRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :info_requests, :note, :string
  end
end
