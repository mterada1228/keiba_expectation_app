module RacesHelper
  def race_schedule(race)
    race.attributes
        .merge('race_date' => race[:race_date].to_s(:stamp))
        .values_at('race_date',
                   'days',
                   'race_course',
                   'round')
        .reject(&:blank?).join(' ')
  end

  def race_condition(race)
    race.attributes
        .merge('distance' => "#{race[:distance]}m",
               'course_type' => I18n.t("enums.race.course_type.#{race[:course_type]}"),
               'turn' => I18n.t("enums.race.turn.#{race[:turn]}"),
               'side' => I18n.t("enums.race.side.#{race[:side]}"))
        .values_at('course_type',
                   'distance',
                   'turn',
                   'side',
                   'regulation1',
                   'regulation2',
                   'regulation3',
                   'regulation4')
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
