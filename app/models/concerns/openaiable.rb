module Openaiable
  extend ActiveSupport::Concern

  included do
    before_save :set_title
  end

  private

  def set_title
    if self.title.blank? && !ENV['OPENAI_KEY'].nil?
      system_message = "Given a memory description as input, generate a concise title that encapsulates the essence of the memory. The title should be in the same language, consist of 7 to 25 words, and be fewer in words than the description itself. Ensure the generated title reflects the main elements of the memory and is concise yet descriptive. Do not add quotation marks to your response."
      self.title = OpenAiService.new("#{self.description.truncate(1000)} #{self.people.map(&:first_name)}", system_message).call
    end
  end
end
