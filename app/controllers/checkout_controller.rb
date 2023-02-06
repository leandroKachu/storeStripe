class CheckoutController < ApplicationController 


  def create
    require 'stripe'
    Stripe.api_key = Rails.application.credentials[:stripe][:secret]
    if params[:id].to_i.positive?
      product = Product.find_by(id:params[:id].to_i)
      @session=Stripe::Checkout::Session.create({
        line_items: [{
          price_data: {
            currency: 'usd',
            product_data: {
              name: product.name,
            },
            unit_amount: product.price,
          },
          quantity: 1,
        }],
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url

      })
      respond_to do |format|
        format.js
      end
    else
      flash[:error] = "Product not found"
    end
  end



  def success ;end

end