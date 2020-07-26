class Pkgbuild

  @data

  def initialize path = "PKGBUILD"
    parser = Parser.new path
    @data = parser.data
  end

  def ok?
    !@data.nil?
  end

  def really?
    return false unless ok?
    return @data.keys.all? do |key|
      self[key]
    end
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

  def iterate &block
    @data.each_pair do |key, val|
      yield(key, val)
    end
  end

  private

  def complete str

    chars = str.split(//)
    buf = ""
    ins = nil
    strict = false

    chars.each_with_index do |c, i|

      if ins

        if strict
          case c
          when "}"
            tmp  = self[ins, false].to_a[0]
            unless tmp
              puts "#{ins} not defined"
              exit 255
            end
            buf << tmp
            ins = nil
          when "{";
          else
            ins << c
          end
        else
          if [" ", "/", "\\", "\"", "'"].include? c
            tmp = self[ins, false].to_a[0]
            unless tmp
              puts "#{ins} not defined"
              exit 255
            end
            buf << tmp << c
            ins = nil
          else
            ins << c
          end
        end

      else

        if c == "$"
          ins = ""
          strict = chars[i + 1] == "{"
        else
          buf << c
        end

      end

    end

    buf

  end

end
