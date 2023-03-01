class Product < ApplicationRecord
  validates :name, :price, presence: true

  def to_s
    name
  end

  def to_builder
    Jbuilder.new do |product|
      product.price stripe_price_id
      product.quantity 1
    end
  end

  after_create do 
    Stripe.api_key = 'sk_test_51MWmjkHFC97yK2BpCHN44H3B5OarVE1biaZjaGbOz0MOH8aN8kw0283EjVIucUqJ52QvUZYtxzkNe7zLOGx2DJ5a00plhTltaZ'
    product =  Stripe::Product.create({name: name})
    price   = Stripe::Price.create({unit_amount: self.price,
      currency: 'brl',
      product: product.id,
    })
    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end
end
