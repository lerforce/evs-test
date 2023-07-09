require 'test_helper'

class Api::First::PotatosControllerTest < ActionDispatch::IntegrationTest

  def setup
    super
  end

  test 'route show exists' do
    assert_routing(
      { path: "api/first/potatos/01-02-2023", method: 'get' },
      { controller: 'api/first/potatos', action: 'show', id: "01-02-2023" }
    )
  end

  test 'raise error on invalid date' do

    get "/api/first/potatos/toto"
    response = JSON.parse(body)

    assert_equal status, 422
    assert_equal  '{"code"=>"error", "message"=>"invalid date"}', response.to_s
  end

  test 'raise error on futur dates' do
    date = Date.today + 1.day

    get "/api/first/potatos/#{date.strftime('%d-%m-%Y')}"
    response = JSON.parse(body)

    assert_equal status, 422
    assert_equal  '{"code"=>"error", "message"=>"invalid date"}', response.to_s
  end

  test 'can list items ordered by time' do
    date = "01-01-2023"
    potato_1 = Potato.create!({ time: DateTime.parse(date) + 10.minutes, value: 100.21 })
    potato_2 = Potato.create!({ time: DateTime.parse(date) + 20.minutes, value: 100.22 })
    potato_3 = Potato.create!({ time: DateTime.parse(date) + 30.minutes, value: 100.23 })

    get "/api/first/potatos/#{date}"
    response = JSON.parse(body)

    assert_equal status, 200
    assert_equal potato_1.value, response[0]["value"]
    assert_equal potato_2.value, response[1]["value"]
    assert_equal potato_3.value, response[2]["value"]
  end

  test 'list only on specified date' do
    date = "01-01-2023"
    potato_1 = Potato.create!({ time: DateTime.parse(date) + 10.minutes, value: 100.21 })
    potato_2 = Potato.create!({ time: DateTime.parse(date) + 20.minutes, value: 100.22 })
    Potato.create!({ time: DateTime.parse(date) + 1.day, value: 100.23 })

    get "/api/first/potatos/#{date}"
    response = JSON.parse(body)

    assert_equal status, 200
    assert_equal 2, JSON.parse(body).count
    assert_equal potato_1.value, response[0]["value"]
    assert_equal potato_2.value, response[1]["value"]
  end

end
