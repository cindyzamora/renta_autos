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
  		puts '---------------------'
  		puts field.inspect
  		puts field.attributes
  		# @product_fields.to_hash
  		# puts @product_fields.inspect

  		fields = Product.select("#{field.nombre}").distinct
  		puts '******************* response'

  		puts fields.inspect
  		response = field.attributes
  		puts response.inspect

  		values = []
  		fields.each do |f|
  			
  			puts ';;;;;;'
  			temp = f.attributes["#{field.nombre}"]
  			puts f.attributes
  			puts field.nombre
  			puts '======='
  			puts temp
  			value = {"name" => temp}
  			values.push(value)
  		end


  		response["values"] = values

  		puts '.........................................'
  		puts fields.inspect
  		puts response.inspect

  		@r.push(response)
  	end
  		puts @r.inspect

  	
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
