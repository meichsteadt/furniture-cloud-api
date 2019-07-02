# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@user = User.create(name: "default", password: "000000", markup_default: 1)

@color_pallete = ColorPallete.create(
  primary_color: "#217B75",
  secondary_color: "#1F7A8C",
  highlight_color: "#c91f24",
  accent_color: "#BFDBF7",
  lowlight_color: "#053C5E",
)

#create store for local
@user.stores.create(
  name: "Furniture Store",
  password: "000000",
  email: "email@furniturestore.com",
  url: "localhost",
  color_pallete_id: @color_pallete.id
)

#create store for web
@user.stores.create(
  name: "Furniture Store",
  password: "000000",
  email: "email@furniturestore.com",
  url: "websites.furniturecloud.co",
  color_pallete_id: @color_pallete.id
)

@parent_categories = [
  ["Bedroom", "https://s3-us-west-1.amazonaws.com/homelegance-resized/Images_MidRes_For+Customer+Advertisement/2159-1.jpg"],
  ["Dining", "https://s3-us-west-1.amazonaws.com/homelegance-resized/Images_MidRes_For+Customer+Advertisement/5179-90.jpg"],
  ["Living Room", "https://s3-us-west-1.amazonaws.com/homelegance-resized/Images_MidRes_For+Customer+Advertisement/8327BE.jpg"],
  ["Youth", "https://s3-us-west-1.amazonaws.com/homelegance-resized/Images_MidRes_For+Customer+Advertisement/B2008TF.jpg"],
  ["Home", "https://s3-us-west-1.amazonaws.com/homelegance-resized/Images_MidRes_For+Customer+Advertisement/5415RF-15DKT%205415RF-16RDT%205415RF-17MT%205415RF-18.jpg"]
]
@parent_categories.each do |pc|
  @user.parent_categories.create(name: pc[0], image: pc[1])
end

require 'csv'
CSV.read("website_categories.csv", headers: true).each do |row|
  pc = ParentCategory.find_by_name(row["parent_category"])
  category = pc.categories.create(name: row["name"], image: row["image"])
  @user.categories << category
end

Brand.create(name: "Homelegance")

HomeleganceApi.new({user_id: 1}).create_products

Product.where("products.name LIKE ?", "%*4%").joins(categories: :parent_category).where("parent_categories.name = 'Youth'").update("4pc Twin Bedroom Set")

@user.products.delete(Product.where.not("products.name LIKE ?", "%*4%").joins(categories: :parent_category).where("parent_categories.name = 'Youth'"))

@user.products.delete(Product.where.not("products.name LIKE ?", "%*4%").joins(categories: :parent_category).where("parent_categories.name = 'Bedroom'"))


@promo = Promotion.create(image: "https://royalfurniturefresno.com/assets/summer_sale2.png", discount: 0.9, user_id: @user.id, name: "Summer Sale")

@bedroom_sets = Category.find_by(name: "Bedroom Sets")
@dining_sets = Category.find_by(name: "Dining Sets")
@promo.products << @bedroom_sets.products.where.not("set_name LIKE ?", "%5pc%")
@promo.products << @dining_sets.products

Product.all.each {|e| e.init_models.create}
Brand.all.each {|e| e.init_models.create}
ParentCategory.all.each {|e| e.init_models.create}
Category.all.each {|e| e.init_models.create}
SetPrice.all.each {|e| e.init_models.create}
Price.all.each {|e| e.init_models.create}
Promotion.all.each {|e| e.init_models.create}







# Royal furniture default
# Store.create(user_id: , google_maps: "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3145.352337236261!2d-121.27389458525514!3d37.968905979724546!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80900d57273ecb7f%3A0xcd188ff2aaaa9b95!2sHome+Styles+Furniture!5e0!3m2!1sen!2sus!4v1526933828443", yelp: "https://www.yelp.com/biz/royal-furniture-fresno", facebook: "https://www.facebook.com/pages/Royal-FurnitureFresno-Ca/348307628575645",instagram: nil,google_reviews_id: nil, twitter: nil, yellow_pages: nil, show_prices: true, promotions: true, name: "Royal Furniture",logo:"https://raw.githubusercontent.com/meichsteadt/royal/master/app/assets/images/logo.jpg", color_pallete_id: 1, url: "royalfurniturefresno.com", email: "bigusa@ymail.com", password: "")
