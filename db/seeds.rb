def random_datetime(date, index)
  (date + (index * 10).minutes).to_datetime
end

dates = ((Date.today - 15.days)..Date.today)
initial_value = 100.0

dates.each do |date|
  144.times do |index| #on assume que l'on ne peut changer la valeur de la patate que toutes les 10 min pour des questions de flood de db
    Potato.create!({ time: random_datetime(date, index), value: initial_value + rand(0.01..0.99).round(2) })
  end
end

#On se retrouve avec 2304 valeurs pour 15 jours
