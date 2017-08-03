module OrdersHelper

  def create_new_payment_from(params_obj)
    {
      :intent => "sale",
      :payer => {
        :payment_method => "credit_card",
        :funding_instruments => [{
          :credit_card => {
            :type => params_obj[:card_type],
            :number => params_obj[:card_number],
            :cvv2 => params_obj[:card_verification],
            :expire_month => params_obj[:expire_month],
            :expire_year => params_obj[:expire_year],
            :first_name => params_obj[:first_name],
            :last_name => params_obj[:last_name],
            :billing_address => {
              :line1 => params_obj[:address],
              :city => params_obj[:city],
              :state => params_obj[:state],
              :postal_code => params_obj[:postal_code],
              :country_code => "US"
            }
          }
        }]
      },
      :transactions => [{
        :amount => {
          :total => params_obj[:amount],
          :currency => "USD"
        },
        :description => "This is the payment transaction description."
      }]
    }
  end

end
