module RacesHelper
  def race_schedule(race)
    race.attributes.values_at('race_date',
                              'days',
                              'start_time',
                              'race_cource',
                              'round').reject(&:blank?).join(' ')
  end

  def race_condition(race)
    race.attributes.merge(distance: "#{race[:distance]}m",
                          cource_type: I18n.t("enums.race.cource_type.#{race[:cource_type]}"),
                          turn: I18n.t("enums.race.turn.#{race[:turn]}"),
                          side: I18n.t("enums.race.side.#{race[:side]}"))
        .values_at(:cource_type,
                   :distance,
                   :turn,
                   :side,
                   'regulation1',
                   'regulation2',
                   'regulation3',
                   'regulation4').reject(&:blank?).join(' ')
  end

  def race_prizes(race)
    race.attributes.values_at('prize1',
                              'prize2',
                              'prize3',
                              'prize4',
                              'prize5').map { |prize| "#{prize}万" }.join(' ')
  end
end
