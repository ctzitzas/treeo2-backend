class PurchasesController < ApplicationController

  before_action :payment_params

  def create

    url = 'http://localhost:3001'

      session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: [{
          price_data: {
            currency: 'aud',
            product_data: {
              name: 'Adopt a tree',
            },
            unit_amount: 100,
          },
          quantity: params[:quantity]
        }],
        mode: 'payment',
        success_url: url + '/AdoptedTree',
        cancel_url: url + '/Adopt'
      })
      redirect_to session.url, status: 303
  end

  def payment_params
    params.permit(:quantity)
  end
end
