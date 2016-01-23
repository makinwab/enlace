class Link < ActiveRecord::Base
  after_create :generate_slug
  
  def generate_slug
    if self.slug == nil
      self.slug = self.id.to_s << 5.times.map { [*'0'..'9', *'a'..'z'].sample }.join
      self.save
    end
  end

  def display_slug
    ENV[:BASE_URL] + self.slug
  end

  def screenshot_scrape
    Screenshot.perform_async(self.id)
    Scrape.perform_async(self.id)
  end
end
