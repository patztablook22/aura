class Pkgbuild

  @data

  def initialize path
    parser = Parser.new path
    @data = parser.data
  end

  def ok?
    !@data.nil?
  end

  def << hash
    hash.each_pair do |key, val|
      unless val.class == Array
        val = [val]
      end
      @data[key] = val
    end
  end

  def [](target, auto = true)

    buf = []
    @data[target].to_a.each do |it|
      buf += [complete(it)]
    end

    if auto
      case buf.size
      when 0; nil
      when 1; buf[0]
      else;   buf
      end
    else
      buf
    end

  end

  private

  def complete str

    tmp = str.split(//)

    buf = ""
    ins = nil

    tmp.each_with_index do |c, i|
      if ins
        case c
        when "}"
          buf += self[ins, false].to_a[0]
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
