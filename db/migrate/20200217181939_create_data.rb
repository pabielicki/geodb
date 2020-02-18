class CreateData < ActiveRecord::Migration[6.0]
  def change
    create_table :data do |t|
      t.string :ip
      t.string :type
      t.string :continent_code
      t.string :continent_name
      t.string :country_code
      t.string :country_name
      t.string :region_code
      t.string :region_name
      t.string :city
      t.string :zip
      t.integer :latitude
      t.integer :longitude

      t.timestamps
    end
  end
end
