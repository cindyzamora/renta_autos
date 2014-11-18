class ProductAvailableFormsController < ApplicationController

	include ActiveModel::Serialization

  respond_to :to_json

	def index
    @product_fields = ProductAvailableForm.all
    render json: @product_fields
  end

  def show
    @product_field = ProductAvailableForm.find(params[:id])
  end

  def new
    @product_field = ProductAvailableForm.new
    # puts @product_fields
  end
 
  def create
    @product_field = ProductAvailableForm.new(product_params)
   
    if @product_field.save
      redirect_to @product_field
    else
      render 'new'
    end
  end

  def edit
    @product_field = ProductAvailableForm.find(params[:id])
  end

  def update
	  @product_field = ProductAvailableForm.find(params[:id])
	 
	  if @product_field.update(product_params)
	    redirect_to @product_field
	  else
	    render 'edit'
	  end
	end

  def form
  	@product_fields = ProductAvailableForm.select("id,nombre, tipo, requerido")

  	@r = []

  	@product_fields.each do |field|

  		fields = Product.select("#{field.nombre}").distinct

  		response = field.attributes

  		values = []
  		fields.each do |f|
  			value_field = f.attributes["#{field.nombre}"]
  			value = {"name" => value_field}
  			values.push(value)
  		end

  		response["values"] = values

  		@r.push(response)
  	end

    render json: @r
  end

  def available_product_fields
  end

  def self.to_hash
	  all.to_a.map(&:serializable_hash)
	end
 
private
  def product_params
    params.require(:product_available_form).permit(:nombre, :tipo, :requerido)
  end

end
