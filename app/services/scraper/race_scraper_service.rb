module Scraper
  # Raceモデルのスクレイピングを実施
  # Usage: Scraper::RaceScraperService.new(url: <データ取得先URL>).call
  # netkeiba の 競走馬データベースからデータを取得
  # （URL例）https://race.netkeiba.com/race/shutuba.html?race_id=202006010911

  class RaceScraperService
    attr_reader :url

    def initialize(url:)
      @url = url
      ActiveRecord::Base.logger = Logger.new($stdout)
    end

    def call
      response = HTTParty.get(url)
      create(parse(response))
    end

    private

    GRADE = {
      'Icon_GradeType1' => Race.grades[:g1],
      'Icon_GradeType2' => Race.grades[:g2],
      'Icon_GradeType3' => Race.grades[:g3],
      'Icon_GradeType15' => Race.grades[:listed],
      'Icon_GradeType5' => Race.grades[:op],
      'Icon_GradeType16' => Race.grades[:three_wins],
      'Icon_GradeType17' => Race.grades[:two_wins],
      'Icon_GradeType18' => Race.grades[:one_win]
    }

    OPERATOR = {
      id: ->(elements) { /race_id=(\w+)/.match(elements[:url])[1] },
      start: lambda do |elements|
        "#{elements[:start_date]} #{/\d.:\d./.match(elements[:race_info].text.split('/')[0])[0]}"
      end,
      course: lambda do |elements|
        Race::COURSE_TRANSLATIONS[/race_id=(\w+)/.match(elements[:url])[1].slice(4..5)]
      end,
      round: ->(elements) { elements[:round].text.delete('R') },
      name: ->(elements) { elements[:name].text.gsub(/\n/, '') },
      grade: lambda do |elements|
        elements[:grade].present? ? GRADE[elements[:grade].first['class'].split[1]] : nil
      end,
      course_type: lambda do |elements|
        Race::COURSE_TYPE_TRANSLATIONS[
          /[芝 ダ 障]./.match(elements[:race_info].text.split('/')[1])[0].strip]
      end,
      distance: ->(elements) { /\d+/.match(elements[:race_info].text.split('/')[1])[0] },
      turn: lambda do |elements|
        Race::TURN_TRANSLATIONS[/\((.)/.match(elements[:race_info].text.split('/')[1])[1]]
      end,
      side: lambda do |elements|
        return nil if / (.)\)/.match(elements[:race_info].text.split('/')[1]).nil?

        Race::SIDE_TRANSLATIONS[/ (.)\)/.match(elements[:race_info].text.split('/')[1])[1]]
      end,
      day_number: ->(elements) { elements[:day_number].text.gsub('日目', '') }
    }.freeze

    def parse(response)
      doc = Nokogiri::HTML(response)
      elements = elements(doc)
      attributes = {}
      OPERATOR.each_key do |column_name|
        attributes[column_name] = OPERATOR[column_name].call elements
      end
      # RaceRegulationのデータ作成
      RaceRegulationScraperService.new(elements: elements).call
      # RacePrizeのデータ作成
      RacePrizeScraperService.new(elements: elements).call
      attributes
    end

    # rubocop:disable Metrics/LineLength
    def elements(doc)
      {
        url: url,
        start_date: doc.css('#RaceList_DateList > dd.Active > a'),
        race_info: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceData01'),
        round: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item01 > span'),
        name: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceName'),
        grade: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceName > span'),
        day_number: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceData02 > span:nth-child(3)'),
        regulations_and_prizes: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceData02')
      }
    end
    # rubocop:enable Metrics/LineLength

    def create(attributes)
      race = Race.find_or_initialize_by(id: attributes[:id])
      race.update_attributes!(attributes)
    end
  end
end
