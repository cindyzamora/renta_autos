class ReservesController < ApplicationController
	respond_to :to_json
  def index
    @reserves = Reserve.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json  { render :json => @reserves.to_json }
    # end
    render json: @reserves
  end

  def show
    @reserve = Reserve.find(params[:id])
  end

  def new
    @reserve = Reserve.new
    puts @reserve
  end
 
  def create
    @reserve = Reserve.new(reserve_params)
   
    if @reserve.save
      redirect_to @reserve
    else
      render 'new'
    end
  end

  def search
    # @params = params[:reserve]
    # @reserve = Reserve.find(params[:reserve])

    @reserves = Reserve.where(nil)

    filtering_params(params).each do |key, value|
      @reserves = @reserves.public_send(key, value) if value.present?
    end
    render json: @reserves

  end

  def form
  end
 
private
  def reserve_params
    params.require(:reserve).permit(:tipo, :marca, :modelo, :linea, :capacidad, :cc, :color)
  end

  def filtering_params(params)
    params.slice(:tipo, :marca, :modelo, :linea, :capacidad, :cc, :color)
  end

end

end
