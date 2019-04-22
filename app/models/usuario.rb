class Usuario < ActiveRecord::Base

  validates_presence_of :nome, :email, :tipo, :telefone
  validates_uniqueness_of :email, message: "Usuário já cadastrado"
  validates_format_of :email,:on => [:create,:update], :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,:message => ": E-mail informado de forma errada"

=begin
  has_many :departamentos_gerentes, dependent: :destroy
  has_many :departamentos, through: :departamentos_gerentes
=end

  belongs_to :departamento
  has_many :logs

  has_secure_password
end
