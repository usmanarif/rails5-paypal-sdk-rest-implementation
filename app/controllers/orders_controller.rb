class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  include OrdersHelper

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @product = Product.find(params[:id])
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    if params[:order][:product_id].present?
      params[:order][:amount] = sprintf "%.2f", params[:order][:amount].to_f
      payment = PayPal::SDK::REST::Payment.new create_new_payment_from(params[:order]) 
      begin
        payment.create
        @order = Order.new(order_params)
        sale = payment.transactions[0].related_resources[0].sale
        @order.assign_attributes({
          payment_method: payment.payer.payment_method,
          sale_id: sale.id,
          status: sale.state,
          amount: payment.transactions[0].amount.total,
          description: payment.transactions[0].description
        })
        @order.save
        redirect_to root_path
      rescue
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:new, :product_id, :ip_address, :first_name, :last_name, :card_type, :card_expires_on, :card_number, :card_verification, :address, :city, :state, :postal_code, :amount, :expire_month, :expire_year, :payment_method, :sale_id, :status, :amount, :description, :donor_id)
    end
end
