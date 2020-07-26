module Console

  def self.<< data

    puts progress(*data)


  end

  private

  def self.progress(type, content = "", meta = nil)

    if !content.start_with? /http(s)?:\/\//
      content = File.basename(content).to_s
    elsif content.length > 45
      content = content[0..20] + "..." + content[-20..-1]
    end

    buf = ""

    case type
    when :aur
      
      buf << "Retrieving [#{content}]"

    when :req

      buf << "Requesting [#{content}]"
      buf << " (#{meta}B)" if meta

    when :tar

      buf << "Extracting [#{content}]"

    else
      return nil
    end

    buf

  end

end
