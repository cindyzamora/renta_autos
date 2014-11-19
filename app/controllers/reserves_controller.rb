require 'json'

class ReservesController < ApplicationController
	respond_to :to_json

  attr_accessor :agencia_cuenta
  # attr_accessor :response
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

    information = request.raw_post
    data_parsed = JSON.parse(information)

    reserve = {}
    response = {}

    @agency = Agency.find_by(codigo: data_parsed["codigo_agencia"])
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
    @agencia_cuenta = data_parsed["agencia_cuenta"]

    reserve["status"] = data_parsed["status"]
    reserve["cliente_nombre"] = data_parsed["cliente_nombre"]
    reserve["cliente_tarjeta"] = data_parsed["cliente_tarjeta"]
    reserve["cliente_dpi"] = data_parsed["cliente_dpi"] 
    reserve["cliente_telefono"] = data_parsed["cliente_telefono"]
    reserve["monto_total"] = data_parsed["monto_total"]
    reserve["codigo"] = data_parsed["codigo_reserva"]
    # reserve["agencia_codigo"] = data_parsed["agencia_codigo"]
    # reserve["agencia_cuenta"] = data_parsed["agencia_cuenta"]

    unless @reserve.nil?

      if @reserve.status == 'activa' &&  (data_parsed["status"] == 'cancelada' || data_parsed["status"] == 'confirmada')
        response = confirm_cancel_reserve(reserve)

      # elsif @reserve.status == 'confirmada' &&  data_parsed["status"] == 'cancelada'
      #   response = confirm_cancel_reserve(reserve)
      else
        response = {:code => '422', :status => 'error', :message => "Accion Invalidad, Reserva #{@reserve.status}."}
      end
    else
      response = {:code => '422', :status => 'error', :message => 'No existe esta reservacion.'}
    end

    render json: response
    
  end

  def confirm_cancel_reserve reserve
    @reserve = Reserve.find_by(codigo: reserve["codigo"])
    @agency = Agency.find(@reserve['agency_id'])
    @carritos_account = CarritosAccount.first

    monto_total = reserve["monto_total"]
    ganacia = 100 - @agency["comision"].to_i
    agencia_monto = (monto_total * @agency["comision"]) / 100
    proveedor_monto = (monto_total * ganacia) / 100

    unless reserve['status'] == "cancelada"

      payment = {}
      payment["codigo_reservacion"] = reserve["codigo"]
      payment["cliente_nombre"] = reserve["cliente_nombre"]
      payment["cliente_tarjeta"] = reserve["cliente_tarjeta"]
      payment["cliente_dpi"] = reserve["cliente_dpi"] 
      payment["cliente_telefono"] = reserve["cliente_dpi"]
      payment["agencia_cuenta"] = @agencia_cuenta
      payment["proveedor_cuenta"] = @carritos_account["account"]
      payment["cliente_monto"] = reserve["monto_total"]
      payment["proveedor_monto"] = proveedor_monto
      payment["agencia_monto"] = agencia_monto


      result = post_payment payment
      if result.code == 200
        reserve["raw_response"] = result.body
        puts '*************************************'
        puts reserve["raw_response"]
        puts result.body.to_json
        # puts result.body.to_json["mensaje"]

        if @reserve.update(reserve)
          response = result.body
        else
          response = {:code => '422', :status => 'error', :message => 'Hubo un problema con la reservacion, por favor intente de nuevo.'}
        end
      else
        response = {:code => '422', :status => 'error', :message => 'Ocurrio un problema en la transaccion.'}
      end

    else
      if @reserve.update(reserve)
          response = {:code => '200', :status => 'cancelada', :message => 'Reservacion cancelada exitosamente.'}
        else
          response = {:code => '422', :status => 'error', :message => 'Hubo un problema con la reservacion, por favor intente de nuevo.'}
        end
    end

    response
  end

  def post_payment payment
    # @banks = Bank.all

    puts payment
    # puts @banks.inspect

    # @banks.each do |k, v|
    #   puts v
    #   puts v["endpoint"]
      # response = HTTParty.post('http://172.20.10.6/proyecto/servicios/solicitud_cobro.php', :body => payment) #anibal
      response = HTTParty.post('http://172.20.10.5/proyectocc6/cobro_agencia.php', :body => payment) #godines
    # end
  end

 
private
  def self.params
    params.require(:reserves).permit(:agency, :fecha_inicio, :fecha_fin, :productos)
  end

  def filtering_params(params)
    params.slice(:tipo, :marca, :modelo, :linea, :capacidad, :cc, :color)
  end

end
