class Pkgbuild

  @data

  def initialize path
    parser = Parser.new path
    @data = parser.data
  end

  def ok?
    !@data.nil?
  end

  def get target, index = 0

    tmp = @data[target]
    if tmp.class == Array
      tmp = tmp[index]&.split('')
    end
    buf = ""
    ins = nil

    return nil unless tmp

    tmp.each_with_index do |c, i|
      if ins
        case c
        when "}"
          buf += get(ins).to_s
          ins = nil
        when "{";
        else
          ins += c
        end
      else
        if c == "$" and tmp[i + 1] == "{"
          ins = ""
        else
          buf += c
        end
      end
    end

    buf
  end

end
