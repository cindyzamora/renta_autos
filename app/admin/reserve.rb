ActiveAdmin.register Reserve do

  permit_params :agency_id, :products, :monto_total, :fecha_inicio, :fecha_fin, :cliente_nombre, :cliente_dpi, :cliente_telefono, :cliente_tarjeta, :status

end
