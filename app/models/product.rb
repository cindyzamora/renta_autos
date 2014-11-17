class Product < ActiveRecord::Base
	scope :id, -> (id) { where id: id }
  scope :tipo, -> (tipo) { where tipo: tipo }
  scope :marca, -> (marca) { where marca: marca }
  scope :modelo, -> (modelo) { where modelo: modelo }
  scope :linea, -> (linea) { where linea: linea }
  scope :capacidad, -> (capacidad) { where capacidad: capacidad }
  scope :cc, -> (cc) { where cc: cc }
  scope :color, -> (color) { where color: color }
  scope :linea, -> (linea) { where("linea like ?", "#{linea}%")}
end
