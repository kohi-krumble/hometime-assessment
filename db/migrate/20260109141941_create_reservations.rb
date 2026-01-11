class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.date :start_at, index: true
      t.date :end_at, index: true
      t.integer :no_of_nights, null: false, default: 1
      t.string :status, null: false, default: 'pending', index: true
      t.monetize :payout_amount, currency: { present: false }
      t.monetize :security_amount, currency: { present: false }
      t.monetize :total_amount, currency: { present: false }
      t.string :currency, null: false, default: 'AUD', index: true
      t.jsonb :details, default: {}

      t.timestamps
    end
  end
end
