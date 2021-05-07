class HorseRaceStats
  def initialize(horse:, column:)
    horse_races = horse.horse_races.includes(:race)
    column = column.to_sym
    attributes = Race.send(column.to_s.pluralize).keys
    create_stats(horse_races, column, attributes)
    create_accesors(attributes)
  end

  def create_stats(horse_races, column, attributes)
    attributes.each do |attribute|
      instance_variable_set("@#{attribute}",
                            HorseRaceStatsValue.new(
                              horse_races.select do |horse_race|
                                horse_race.race[column] == attribute
                              end
                            ))
    end
  end

  def create_accesors(attributes)
    attributes.each do |attribute|
      create_accesor(attribute)
    end
  end

  def create_accesor(attribute)
    self.class.class_eval do
      define_method attribute do
        instance_variable_get "@#{attribute}"
      end
    end
  end
end
