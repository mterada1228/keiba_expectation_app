module RacesHelper
  def race_schedule(race)
    race_schedule = race.slice(:race_date, :days,
                               :start_time, :race_cource, :round).values
    race_schedule.reject(&:blank?).join(' ')
  end

  def race_condition(race)
    race_condition = []
    race_condition << race[:cource_type]
    race_condition << "#{race[:distance]}m"
    race_condition.concat(race.slice(:turn, :side, :regulation1, :regulation2, :regulation3, :regulation4).values)
    race_condition.reject(&:blank?).join(' ')
  end

  def race_prizes(race)
    race_prizes = []
    race.slice(:prize1, :prize2,
               :prize3, :prize4, :prize5).values.each do |prize|
      race_prizes << "#{prize}万"
    end
    race_prizes.join(' ')
  end
end
