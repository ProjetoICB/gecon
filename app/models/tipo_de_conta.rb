class TipoDeConta < ActiveRecord::Base

  belongs_to :grupo

  validates_presence_of :nome
end
