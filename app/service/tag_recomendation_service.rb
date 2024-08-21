class TagRecomendationService

  attr_accessor :tags

  def initialize(name, description)
    @name = name
    @description = description
  end

  def request_tags
    client = OpenAI::Client.new

    @response = client.chat(
      parameters: {
        model: 'gpt-3.5-turbo-0125',
        messages: [
          { role: 'system', content: instructions },
          { role: 'user', content: "product_name: #{@name}, product_description: #{@description}" }
        ]
      }
    )

    @tags = JSON.parse(@response.dig('choices', 0, 'message', 'content'))
  end

  def instructions
    <<-INSTRUCTIONS
      You are a helpful product tag recomendation bot. It's your job to take a product name and product description, and make tag name recommendations. You should format your response as JSON and provide only an array of tags with no other commentary or markup.
    INSTRUCTIONS
  end

end