class CreateErpCurrenciesCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_currencies_currencies do |t|
      t.string :name
      t.string :code
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users

      t.timestamps
    end
  end
end
