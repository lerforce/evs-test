class InvalidDateError < StandardError
  STATUS_CODE = 422

  def initialize(message = "invalid date")
    super(message)
  end
end
