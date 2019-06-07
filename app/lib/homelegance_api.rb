class HomeleganceApi
  Dotenv::Railtie.load

  attr_accessor :kiosk_url, :sales_url, :sales_username, :sales_password, :sales_auth_token, :best_sellers, :kiosk_products, :kiosk_product_items, :kiosk_product_categories, :kiosk_set_prices, :user, :created_products
  def initialize(params)
    @user = User.find(params[:user_id])
    @kiosk_url = "http://localhost:3001"
    @sales_url = "http://localhost:3002"
    @sales_username = ENV['sales_username']
    @sales_password = ENV['sales_password']
    @sales_auth_token = authenticate_sales
    @headers = {'Authorization': @sales_auth_token}
    @best_sellers = get_best_sellers
    @kiosk_products = get_kiosk_products
    @kiosk_product_items = get_kiosk_product_items
    @kiosk_product_categories = get_kiosk_categories
    @kiosk_set_prices = get_set_prices
    @created_products = []
  end

  def authenticate_sales
    JSON.parse(RestClient.post(@sales_url + "/authenticate", {email: @sales_username, password: @sales_password}).to_s)["auth_token"]
  end

  def get_best_sellers
    JSON.parse(RestClient.get(@sales_url + "/products?all=true", @headers).to_s).map {|e| e["number"]}
  end

  def get_kiosk_products
    JSON.parse(RestClient.post(@kiosk_url + "/products_where?products=true", {numbers: @best_sellers}))
  end

  def get_kiosk_product_items
    JSON.parse(RestClient.post(@kiosk_url + "/products_where?product_items=true", {product_ids: @kiosk_products.map {|e| e["id"]}}))
  end

  def get_kiosk_categories
    JSON.parse(RestClient.post(@kiosk_url + "/products_where?categories=true", {product_ids: @kiosk_products.map {|e| e["id"]}}))
  end

  def get_set_prices
    JSON.parse(RestClient.post(@kiosk_url + "/products_where?prices=true", {numbers: @kiosk_products.map {|e| e["number"]}}))
  end

  def create_products
    @kiosk_products.each_with_index do |p, i|
      parent_category = p["category"]
      prices = @kiosk_set_prices.find_all {|e| e[0] =~ /#{p["number"].delete("*")}*/}
      prices.each do |price|
        set = set_descs(parent_category, price[0], i)
        prod = @user.products.create(
          name: p["number"],
          description: p["description"],
          images: p["images"],
          thumbnail: p["thumbnail"],
          brand_id: 1,
          set_desc: set[:desc],
          set_name: set[:name],
        )

        categories = @kiosk_product_categories[prod.name]
        if categories
          categories.each do |cat|
            prod.categories << Category.find_by(
              parent_category_id: ParentCategory.find_by(name: parent_category.titlecase).id,
              name: cat
            )
          end
        end

        @user.set_prices.create(
          product_id: prod.id,
          price: round(price[1] * @user.stores.first.markup_default)
        )
      end
    end
  end

  def create_product_items
    @kiosk_product_items.each do |p|
      products = Product.where(name: p["product_number"])
      products.each do |prod|
        pi = prod.product_items.create(
          dimensions: p["dimensions"],
          name: p["description"],
          price: p["price"],
        )

        pi.prices.create(user_id: @user.id, price: round(pi.price * @user.stores.first.markup_default))
      end
    end
  end

  def set_descs(category, number, i)
    if number.split("*").length > 1
      if number =~ /\*9/
        if category == "bedroom" || category == "youth"
          return {
            desc:"Bed, Nightstand, Dresser, Mirror, Chest",
            name: "5pc Queen Bedroom Set"
          }
        end
      elsif number =~ /\*4/
        if category == "bedroom" || category == "youth"
          return {
            desc:"Bed, Nightstand, Dresser, Mirror",
            name: "4pc Queen Bedroom Set"
          }
        end
      elsif number =~ /\*5/
        if category == "bedroom" || category == "youth"
          return {
            desc:"Bed, Nightstand(2), Dresser, Mirror",
            name: "5pc Queen Bedroom Set"
          }
        elsif category == "dining"
          return {
            desc:"Table, Chairs(4)",
            name: "5pc Dining Set"
          }
        end
      end
    end
    return {
      name: nil,
      desc: nil
    }
  end

  def round(number)
    return ((number / 10).ceil)  * 10 - 1
  end
end
