require 'json'

class ProductsController < ApplicationController
  respond_to :to_json
  def index
    @products = Product.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json  { render :json => @products.to_json }
    # end
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    puts @product
  end
 
  def create
    @product = Product.new(product_params)
   
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def search
    # @params = params[:product]
    # @product = Product.find(params[:product])

    @products = Product.where(nil)

    filtering_params(params).each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
    render json: @products

  end

  def form
  end

  def available_products
  end
 
private
  def product_params
    params.require(:product).permit(:tipo, :marca, :modelo, :linea, :capacidad, :cc, :color)
  end

  def filtering_params(params)
    params.slice(:tipo, :marca, :modelo, :linea, :capacidad, :cc, :color)
  end

end
