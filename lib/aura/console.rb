module Console

  def self.<< data

    puts progress(*data)


  end

  private

  def self.progress(type, content = "")

    unless content.start_with? /http(s)?:\/\//
      content = File.basename(content).to_s
    end

    case type
    when :aur
      return "Retrieving [#{content}]"
    when :req
      return "Requesting [#{content}]"
    when :tar
      return "Extracting [#{content}]"
    else
      return nil
    end

  end

end
