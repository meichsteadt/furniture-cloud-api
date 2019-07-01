class CreateColorPalletes < ActiveRecord::Migration[5.0]
  def change
    create_table :color_palletes do |t|
      t.string :primary_color
      t.string :secondary_color
      t.string :highlight_color
      t.string :lowlight_color
      t.string :accent_color

      t.timestamps
    end
  end
end
