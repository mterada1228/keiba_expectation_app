class ScrapeDataFromNetkeibaJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    p "Hello Active Job."
  end
end
