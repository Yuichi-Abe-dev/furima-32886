=begin 商品購入機能実装時にコメントアウトを外す
class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :user,          null: false, foreign_key: true
      t.references :item,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
=end
