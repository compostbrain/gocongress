class Tournament::Import
  include ActiveModel::Model
  attr_accessor :file, :tournament_id, :imported_count

  def intialize
    @tournament = Tournament.find_by(id: :tournament_id)
  end
  
  def process!
    errors.add(:base, "Error")
  end

  def save
    process!
    errors.none?
  end
   
end