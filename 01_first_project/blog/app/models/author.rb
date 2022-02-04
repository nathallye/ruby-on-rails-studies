class Author < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :description, allow_nil: true, length: { maximum: 500 }
  # Para saber mais sobre as validações do rails => https://guides.rubyonrails.org/active_record_validations.html

  after_validation :titleize_last_name, if: Proc.new { |a| a.last_name.present? }, on: create # Active Record Callback

  has_one :address, dependent: :destroy # tem_um :endereço (depentent: :destroy => se o author desse endereço for excluído, ele também será) 
  # se fosse uma associação do tipo has_many, ficaria assim => has_many :addresses(tem_varios :enderesços)
  has_many :posts

  private
  def titleize_last_name
    self.last_name = last_name.titleize
  end
  
end
