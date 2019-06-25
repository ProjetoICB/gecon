class TipoDeConta < ActiveRecord::Base

  belongs_to :grupo
  has_many :contas



  validates_presence_of :nome
  validates_presence_of :grupo_id
end
