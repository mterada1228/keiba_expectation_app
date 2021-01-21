module Scraper
  # Raceモデルのスクレイピングを実施
  # 海外競馬の場合はこちらを利用する
  # Usage: Scraper::RaceAbroadScraperService.new(url: <データ取得先URL>).call
  # netkeiba の 競走馬データベースからデータを取得
  # （URL例）https://race.netkeiba.com/race/shutuba.html?race_id=2019C8100604

  class RaceAbroadScraperService
    attr_reader :url, :doc

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
        id = /race_id=(\w+)/.match(elements[:url])[1]
        start_date = "#{id.slice(0..3)}#{id.slice(6..9)}"
        "#{start_date} #{/\d.:\d./.match(elements[:race_info].text.split('/')[2])[0]}"
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
          /[芝 ダ 障]./.match(elements[:race_info].text.split('/')[0])[0].strip]
      end,
      distance: ->(elements) { /\d+/.match(elements[:race_info].text.split('/')[0])[0] },
      turn: lambda do |elements|
        Race::TURN_TRANSLATIONS[/\((.)/.match(elements[:race_info].text.split('/')[0])[1]]
      end
    }.freeze

    def parse(response)
      @doc = Nokogiri::HTML(response)
      attributes = {}
      OPERATOR.each_key do |column_name|
        attributes[column_name] = OPERATOR[column_name].call elements
      end
      attributes
    end

    # rubocop:disable Metrics/LineLength
    def elements
      @elements ||= {
        url: url,
        race_info: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceData01'),
        round: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item01 > span'),
        name: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceName'),
        grade: doc.css('#page > div.RaceColumn01 > div > div.RaceMainColumn > div.RaceList_NameBox > div.RaceList_Item02 > div.RaceName > span')
      }
    end
    # rubocop:enable Metrics/LineLength

    def create(attributes)
      # HorseRaceResultのデータ保存
      race = Race.find_or_initialize_by(id: attributes[:id])
      race.update_attributes!(attributes)
    end
  end
end
