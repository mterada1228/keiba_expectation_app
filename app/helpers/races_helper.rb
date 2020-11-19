module RacesHelper
  def race_schedule(race)
    day_number = "#{race.day_number}日目" if race.day_number.present?

    race.attributes
        .merge('start' => race.start.to_s(:stamp),
               'day_number' => day_number,
               'round' => "#{race.round}R")
        .values_at('start',
                   'day_number',
                   'course',
                   'round')
        .reject(&:blank?).join(' ')
  end

  def race_condition(race)
    side = I18n.t("enums.race.side.#{race.side}") if race.side.present?

    race.attributes
        .merge('course_type' => I18n.t("enums.race.course_type.#{race.course_type}"),
               'distance' => "#{race.distance}m",
               'turn' => I18n.t("enums.race.turn.#{race.turn}"),
               'side' => side)
        .values_at('course_type', 'distance', 'turn', 'side',
                   'regulation1', 'regulation2', 'regulation3', 'regulation4')
        .reject(&:blank?).join(' ')
  end

  def race_prizes(race)
    race.attributes
        .values_at('prize1',
                   'prize2',
                   'prize3',
                   'prize4',
                   'prize5')
        .map { |prize| "#{prize}万" }
        .reject(&:blank?).join(' ')
  end
end
