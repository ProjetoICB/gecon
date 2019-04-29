class TipoDeConta < ActiveRecord::Base

  belongs_to :grupo
  has_many :contas



  validates_presence_of :nome
end
