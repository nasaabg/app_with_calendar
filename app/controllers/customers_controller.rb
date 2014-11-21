class CustomersController < ApplicationController

  def new
    build_customer
  end

  def create
    build_customer
    save_customer or render 'new'
  end

  private

    def build_customer
      @customer = customer_scope.build(customer_parmas)
    end

    def customer_parms
      customer_params = params[:customer]
      customer_parms ? params.require(:customer).permit(:name, :surname, :email, :phone) : {}
    end
end
