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
    aaa = true
    @kiosk_products.each_with_index do |p, i|
      parent_category = p["category"]
      # puts "***********************#{parent_category}**************************"
      prices = @kiosk_set_prices.find_all {|e| e[0] =~ /#{p["number"].delete("*")}\*/}

      prices = @kiosk_set_prices.find_all {|e| e[0] =~ /#{p["number"]}/} if prices.empty? && parent_category == "seating" && p["number"] =~ /-3$/

      prices.each do |price|
        unless Product.find_by(name: price[0])
          set = set_descs(parent_category, price[0], i)
          prod = @user.products.create(
            name: price[0],
            description: p["description"],
            images: p["images"],
            thumbnail: p["thumbnail"],
            brand_id: 1,
            set_desc: set[:desc],
            set_name: set[:name],
          )

          categories = @kiosk_product_categories[prod.name.split("*")[0]]
          categories ||= @kiosk_product_categories[prod.name.split("*")[0]+ "*"]

          # do some different stuff if its seating
          if categories && categories.include?("Sofa Love Sets")
            categories = ["Sofa Love Sets"]
            add_price = @kiosk_set_prices.find {|e| e[0] =~ /#{p["number"].gsub("-3", "-2")}/}
            add_price = add_price[1] unless add_price.empty?
            if aaa
              # aaa = false
            end
            price[1] += add_price
          end

          if categories
            categories.each do |category|
              if parent_category == "seating"
                prod.categories << Category.find_by(
                  parent_category_id: ParentCategory.find_by(name: "Living Room").id,
                  name: category
                )
              else
                prod.categories << Category.find_by(
                  parent_category_id: ParentCategory.find_by(name: parent_category.titlecase).id,
                  name: category
                )
              end
            end
          end

          @user.set_prices.create(
            product_id: prod.id,
            price: price[1] *  @user.markup_default
          )

          create_product_items(p["id"], prod)
        end
      end
    end
    create_beds_only
  end

  def create_beds_only
    ParentCategory.find_by(name: "Bedroom").products.where("products.name LIKE ?", "%-1%").except(:id).each do |product|
      name = product.name.split("*")[0] + "*"
      unless Product.find_by(name: name)
        new_prod = Product.new(product.attributes.except("id"))
        new_prod.set_desc = "Bed"
        new_prod.set_name = "Bed"
        new_prod.name = name

        product.product_items.where("lower(name) LIKE ?", "%bed%").each do |pi|
          new_pi = new_prod.product_items.new(
            dimensions: pi["dimensions"],
            name: pi["name"],
            price: pi["price"]
          )
          new_pi.prices.new(user_id: @user.id, price: pi.price * @user.markup_default)
        end

        # puts new_prod

        price = new_prod.product_items.find_all {|e| e.name =~ /Queen/}.first
        if price
          price = price.price
          if new_prod.save!
            @user.products << new_prod
            new_prod.set_prices.create(user_id: @user.id, price: price * @user.markup_default)
            new_prod.categories << Category.find_by(name: "Beds/Headboards")
          end
        end
      end
    end
  end

  def create_product_items(product_id, product)
    @kiosk_product_items.select {|e| e["product_id"] == product_id}.each do |p|
      if p["price"]
        pi = product.product_items.create(
          dimensions: p["dimensions"],
          name: p["description"],
          price: p["price"],
        )

        pi.prices.create(user_id: @user.id, price: pi.price * @user.markup_default)
      end
    end
  end

  def set_descs(category, number, i)
    if number.split("*").length > 1
      if number =~ /\*9/
        if category == "bedroom"
          return {
            desc:"Bed, Nightstand, Dresser, Mirror, Chest",
            name: "5pc Queen Bedroom Set"
          }
        end
      elsif number =~ /\*4/
        if category == "bedroom"
          return {
            desc:"Bed, Nightstand, Dresser, Mirror",
            name: "4pc Queen Bedroom Set"
          }
        end
      elsif number =~ /\*5/
        if category == "bedroom"
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
    elsif number.split("-").length > 1 && number.split("-")[1] == "3"
      if category == "seating"
        return {
          desc:"Sofa Love Set",
          name: "Sofa & Love Seat"
        }
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
