module RacesHelper
  def race_description_row1(race)
    row1 = race.slice(:race_date, :days, :start_time, :race_cource, :round).values
    row1.reject(&:blank?).join(' ')
  end

  def race_description_row2(race)
    row2 = []
    row2 << race[:cource_type]
    row2 << race[:distance] + 'm'
    row2.concat(race.slice(:turn, :side, :regulation1, :regulation2, :regulation3, :regulation4).values)
    row2.reject(&:empty?).join(' ')
  end

  def race_description_row3(race)
    row3 = []
    race.slice(:prize1, :prize2, :prize3, :prize4, :prize5).values.each do |prize|
      row3 << "#{prize}万"
    end
    row3.join(' ')
  end
end
