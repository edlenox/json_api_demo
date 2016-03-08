
class JokeService

  def self.random_joke(person=nil)
    params =""
    if person
      params = "?firstName=#{person.first_name}&lastName=#{person.last_name}"
    end

    response = HTTParty.get("http://api.icndb.com/jokes/random#{params}")

    success = response.parsed_response["type"] rescue nil

    if success == "success"
      return response.parsed_response["value"]["joke"]
    else
      Rails.logger.warn(response.inspect)
      return "problem getting joke"
    end
  end

end


