class User < ApplicationRecord

  has_secure_password

  attr_accessor :avatar_file
  validates :username,
              format: {with: /\A[a-zA-z0-9_@.]+\z/, message: 'ne peut contenir que des caracteres alphanumerique et "_@.".'},
              length: {in: 4...20, too_short: 'nombre de caracteres minimum : 4.', too_long: 'nombre de caracteres maximum : 20.'},
              uniqueness: {case_sensitive: false, message: "ce nom d'utilisateur est deja pris."}
  validates :email,
              format: {with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "format d'email invalide."},
              uniqueness: {case_sensitive: false, message: "cette email est deja pris."}
  validates :avatar_file,
              file: {ext: [:jpg, :png, :jpeg]}


  def to_session
    {id: id}
  end
end
