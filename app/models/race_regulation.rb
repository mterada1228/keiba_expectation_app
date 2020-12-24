class RaceRegulation < ApplicationRecord
  belongs_to :race

  enum regulation: {
    handle_race_3_age_and_up: 0,
    thoroughbred_3_age_and_up: 1,
    thoroughbred_3_age: 2,
    thoroughbred_2_age: 3,
    op: 4,
    three_wins: 5,
    two_wins: 6,
    one_win: 7,
    not_win: 8,
    new_horse: 9,
    international_race: 10,
    special_race: 11,
    designated_exchange_race: 12,
    mixed_stags_and_mares: 13,
    mares: 14,
    apprentice_jockey: 15,
    special_weight: 16,
    weight_for_age: 17,
    handicap: 18,
    age: 19
  }

  REGULATION_TRANSLATIONS = {
    '障害３歳以上' => RaceRegulation.regulations[:handle_race_3_age_and_up],
    'サラ系３歳以上' => RaceRegulation.regulations[:thoroughbred_3_age_and_up],
    'サラ系３歳' => RaceRegulation.regulations[:thoroughbred_3_age],
    'サラ系２歳' => RaceRegulation.regulations[:thoroughbred_2_age],
    'オープン' => RaceRegulation.regulations[:op],
    '３勝クラス' => RaceRegulation.regulations[:three_wins],
    '２勝クラス' => RaceRegulation.regulations[:two_wins],
    '１勝クラス' => RaceRegulation.regulations[:one_win],
    '未勝利' => RaceRegulation.regulations[:not_win],
    '新馬' => RaceRegulation.regulations[:new_horse],
    '国際' => RaceRegulation.regulations[:international_race],
    '特' => RaceRegulation.regulations[:special_race],
    '指' => RaceRegulation.regulations[:designated_exchange_race],
    '混' => RaceRegulation.regulations[:mixed_stags_and_mares],
    '牡・牝' => RaceRegulation.regulations[:mixed_stags_and_mares],
    '牝' => RaceRegulation.regulations[:mares],
    '見習騎手' => RaceRegulation.regulations[:apprentice_jockey],
    '別定' => RaceRegulation.regulations[:special_weight],
    '定量' => RaceRegulation.regulations[:weight_for_age],
    'ハンデ' => RaceRegulation.regulations[:handicap],
    '馬齢' => RaceRegulation.regulations[:age]
  }
end
