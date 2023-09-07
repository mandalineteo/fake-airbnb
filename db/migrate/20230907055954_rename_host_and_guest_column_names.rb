class RenameHostAndGuestColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :listings, :user_id, :host_id
    rename_column :bookings, :user_id, :guest_id
  end
end
