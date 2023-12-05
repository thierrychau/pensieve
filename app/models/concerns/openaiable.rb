module Openaiable
  extend ActiveSupport::Concern

  included do
    before_save :set_title
  end

  private

  def set_title
    if self.title.blank? && !ENV['OPENAI_KEY'].nil?
      system_message = "You are a multilingual copywriter. You will respond to the user's message with a title consisting of 7 to 25 words, ideally 20 words. Your response should be in the same language as the user's message and shall not be longer than the description itself."
      self.title = OpenAiService.new(self.description.truncate(500), system_message).call
    end
  end
end
