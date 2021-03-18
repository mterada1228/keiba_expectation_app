module Scraper
  class Creator
    class << self
      def create(record)
        record.save
      rescue ActiveRecord::RecordNotUnique
        attributes = record.attributes
        record = record.class.find(record[record.class.primary_key])
        record.update(attributes)
      end
    end
  end
end
