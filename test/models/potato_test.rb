require 'test_helper'

class PotatoTest < ActiveSupport::TestCase

  test 'can create potato' do
    params = {time: DateTime.now, value: 1.1}

    potato = Potato.create!(params)

    assert potato.valid?
    assert_equal params[:time], potato.time
    assert_equal params[:value], potato.value
  end

  test 'potato cannot have empty time' do
    params = {value: 1.1}

    potato = Potato.create(params)

    assert potato.invalid?
    assert_raise(Exception) {
      potato.validate!
    }
  end

  test 'potato cannot have empty value' do
    params = {time: DateTime.now}

    potato = Potato.create(params)

    assert potato.invalid?
    assert_raise(Exception) {
      potato.validate!
    }
  end

  test 'potatoes cannot have the same time' do
    params = {time: DateTime.now, value: 1.1}

    potato = Potato.create!(params)
    potato_2 = Potato.create(params)

    assert potato.valid?
    assert potato_2.invalid?
    assert_raise(Exception) {
      potato_2.validate!
    }
  end

end