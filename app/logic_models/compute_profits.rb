class ComputeProfits
  include ActiveModel::Model

  attr_accessor :date

  def process!
    validate!
    potatos = ::Potato.where("time >= ? AND time <= ?", date.beginning_of_day, date.end_of_day)
    min = potatos.minimum(:value)
    average_potatos = potatos.where.not(value: min)
    average = average_potatos.average(:value)
    (100 * (average - min)).round(2)
  end

end
