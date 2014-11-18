require 'json'

class ReservesController < ApplicationController
	respond_to :to_json

  attr_accessor :endpoint

  def index
    @reserves = Reserve.all
    render json: @reserves
  end

  def show
    @reserve = Reserve.find(params[:id])
  end

  def new
    # @reserve = Reserve.new
    puts @reserve
  end
 
  def create
    # @reserve = Reserve.new(params)
    # params.to_json

    information = request.raw_post
    data_parsed = JSON.parse(information)

    reserve = {}
    response = {}

    @agency = Agency.find_by(codigo: data_parsed["agencia_codigo"])
    puts @agency.inspect


    unless @agency.nil?
      date = Time.now

      codigo_reserva = "R"+(date.to_i).to_s

      reserve["status"] = "activa"
      reserve["codigo"] = codigo_reserva
      reserve["fecha_inicio"] = data_parsed["fecha_inicio"]
      reserve["fecha_fin"] = data_parsed["fecha_fin"]
      reserve["productos"] = data_parsed["productos"].to_s
      reserve["agency_id"] = @agency.id

      @reserve = Reserve.new(reserve)

      if @reserve.save
        response = {:code => '200', :codigo_reserva => codigo_reserva, :status => 'activa'}
      else
        response = {:code => '500', :status => 'error', :message => 'No se pudo guardar la transaccion, intente de nuevo.'}
      end

    else
      response = {:code => '422', :status => 'error', :message => 'Agencia no autorizada.'}
    end

      render json: response
  
  end


  def update

    information = request.raw_post
    data_parsed = JSON.parse(information)

    @reserve = Reserve.find_by(codigo: data_parsed["codigo_reserva"])
    reserve = {}
    response = {}

    unless @reserve.nil?

      if @reserve.status == 'activa'
        reserve["status"] = data_parsed["status"]
        reserve["cliente_nombre"] = data_parsed["cliente_nombre"]
        reserve["cliente_tarjeta"] = data_parsed["cliente_tarjeta"]
        reserve["cliente_dpi"] = data_parsed["cliente_dpi"] 
        reserve["cliente_telefono"] = data_parsed["cliente_dpi"]
        reserve["monto_total"] = data_parsed["monto_total"]


        if @reserve.update(reserve)
            response = {:code => '200', :codigo_reserva => data_parsed["codigo_reserva"], :status => data_parsed["status"]}
        else
          response = {:code => '422', :status => 'error', :message => 'Hubo un problema con la reservacion, por favor intente de nuevo.'}
        end

      else
        response = {:code => '422', :status => 'error', :message => "Accion Invalidad, Reserva #{@reserve.status}."}

      end
    else
      response = {:code => '422', :status => 'error', :message => 'No existe esta reservacion.'}
    end

      render json: response
    
  end

 
private
  def self.params
    params.require(:reserves).permit(:agency, :fecha_inicio, :fecha_fin, :productos)
  end

  def filtering_params(params)
    params.slice(:tipo, :marca, :modelo, :linea, :capacidad, :cc, :color)
  end

end
