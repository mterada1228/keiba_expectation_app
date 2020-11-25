require 'HTTParty'

def parse(html)
  url = html.request.path.to_s
  doc = Nokogiri::HTML(html)

  {
    id: url.gsub(/\d+$/).first,
    name: doc.css('div.horse_title > h1').children[0].text.gsub(/[[:space:]]/, '')
  }
end

def create(data)
  horse = Horse.find_or_initialize_by(id: data[:id])
  horse.update_attributes!(data)
end

ActiveRecord::Base.logger = Logger.new($stdout)

html = HTTParty.get(ARGV[0])
create(parse(html))
