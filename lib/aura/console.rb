module Console

  def self.<< data

    puts progress(*data)


  end

  private

  def self.progress(type, content)

    content = File.basename(content).to_s

    case type
    when :req
      return "Requesting [#{content}]"
    when :tar
      return "Extracting [#{content}]"
    else
      return nil
    end

  end

end
