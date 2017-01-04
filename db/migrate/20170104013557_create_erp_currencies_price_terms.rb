class CreateErpCurrenciesPriceTerms < ActiveRecord::Migration[5.0]
  def change
    create_table :erp_currencies_price_terms do |t|
      t.string :name
      t.string :code
      t.string :use_for
      t.boolean :archived, default: false
      t.references :creator, index: true, references: :erp_users
      t.references :currency, index: true, references: :erp_currencies_currencies

      t.timestamps
    end
  end
end
