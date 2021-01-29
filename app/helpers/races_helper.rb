module RacesHelper
  def race_schedule(race)
    race.attributes
      .merge('start' => race.start.to_s(:date_hour_min),
             'day_number' => race.day_number.try { |number| "#{number}日目" },
             'course' => I18n.t("enums.race.course.#{race.course}"),
             'round' => "#{race.round}R")
      .values_at('start',
                 'day_number',
                 'course',
                 'round')
      .reject(&:blank?).join(' ')
  end

  def race_condition(race)
    race.attributes
      .merge('course_type' => I18n.t("enums.race.course_type.#{race.course_type}"),
             'distance' => "#{race.distance}m",
             'turn' => I18n.t("enums.race.turn.#{race.turn}"),
             'side' => race.side.try { |side| I18n.t("enums.race.side.#{side}") })
      .values_at('course_type', 'distance', 'turn', 'side')
      .concat(race.race_regulations.map do |regulation|
        I18n.t("enums.race_regulation.#{regulation.regulation}")
      end)
      .reject(&:blank?).join(' ')
  end

  def race_prizes(race)
    race.race_prizes.map { |prize| "#{prize.prize}万" }.join(' ')
  end
end
