require "http"
require "json"

class OpenAiService
  BASE_HEADER = {
    "Authorization" => "Bearer #{ENV["OPENAI_KEY"]}",
    "content-type" => "application/json"
  }
  BASE_URL = "https://api.openai.com/v1/chat/completions"

  def initialize(user_message, system_message = "You are a helpful assistant", model = "gpt-3.5-turbo")
    @messages = []
    @model = model
    add_message(system_message, "system")
    add_message(user_message, "user")
  end

  def call
    get_response
  end

  private
    def add_message(content, role = "user")
      @messages << { role: role, content: content }
    end

    def get_response
      request_body_json = JSON.generate({ "model" => @model, "messages" => @messages })
      raw_response = HTTP.headers(BASE_HEADER).post(BASE_URL, body: request_body_json)
      parsed_response = JSON.parse(raw_response)
      response_content = parsed_response.dig("choices", 0, "message", "content")
    end
end
