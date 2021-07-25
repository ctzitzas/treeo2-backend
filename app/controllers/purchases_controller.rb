class PurchasesController < ApplicationController

  def create

    url = 'http://localhost:3001/'

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
          quantity: 1,
        }],
        mode: 'payment',
        success_url: url + 'MyTrees',
        cancel_url: url + 'MyTrees'
      })
      redirect_to session.url, status: 303
  end
end
