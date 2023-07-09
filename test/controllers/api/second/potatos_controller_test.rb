require 'test_helper'

class Api::Second::PotatosControllerTest < ActionDispatch::IntegrationTest

  def setup
    super
  end

  test 'route show exists' do
    assert_routing(
      { path: "api/second/potatos/01-02-2023", method: 'get' },
      { controller: 'api/second/potatos', action: 'show', id: "01-02-2023" }
    )
  end

  test 'raise error on invalid date' do

    get "/api/second/potatos/toto"
    response = JSON.parse(body)

    assert_equal status, 422
    assert_equal  '{"code"=>"error", "message"=>"invalid date"}', response.to_s
  end

  test 'raise error on futur dates' do
    date = Date.today + 1.day

    get "/api/second/potatos/#{date.strftime('%d-%m-%Y')}"
    response = JSON.parse(body)

    assert_equal status, 422
    assert_equal  '{"code"=>"error", "message"=>"invalid date"}', response.to_s
  end

  test 'can process profits' do
    date = "01-01-2023"
    Potato.create!({ time: DateTime.parse(date) + 10.minutes, value: 100.25 })
    Potato.create!({ time: DateTime.parse(date) + 20.minutes, value: 100.29 })
    Potato.create!({ time: DateTime.parse(date) + 30.minutes, value: 100.29 })

    get "/api/second/potatos/#{date}"
    response = JSON.parse(body)

    assert_equal status, 200
    assert_equal "4.0€", response["value"]
  end

end
