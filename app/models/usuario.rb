class Usuario < ActiveRecord::Base

  validates_presence_of :nome, :email, :tipo, :telefone
  validates_uniqueness_of :email, message: "Usuário já cadastrado"
  validates_format_of :email,:on => [:create,:update], :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message => ": E-mail informado de forma errada"


  has_and_belongs_to_many :departamentos, dependent: :destroy
  has_many :logs, dependent: :destroy
  has_many :contas

  has_secure_password
end
