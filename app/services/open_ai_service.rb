class OpenAiService
  BASE_HEADER = {
    "Authorization": "Bearer #{ENV["OPENAI_KEY"]}",
    "content-type": "application/json"
  }
  BASE_URL = "https://api.openai.com/v1/chat/completions".freeze

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
    response = make_request
    response.dig("choices", 0, "message", "content")
  end

  def make_request
    request_body_json = JSON.generate({ "model": @model, "messages": @messages })
    raw_response = HTTP.headers(BASE_HEADER).post(BASE_URL, body: request_body_json)
    JSON.parse(raw_response)
  end
end
