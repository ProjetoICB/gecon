class TipoDeCompra < ActiveRecord::Base
  validates_presence_of :nome
end
