class Transferencia < ActiveRecord::Base
  has_many :lancamentos, dependent: :destroy

end
