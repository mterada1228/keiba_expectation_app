class ScrapeDataFromNetkeibaJob < ApplicationJob
  queue_as :default

  def perform
    Scraper::TopPageScraperService.new.call
  end
end
