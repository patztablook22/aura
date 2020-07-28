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

    missing = []

    @data.each_key do |key|
      begin
        self[key]
      rescue => e
        missing.push "missing constant: #{e.message}"
      end
    end

    missing.each do |it|
      Console << it
    end

    missing.none?

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
            raise ins unless tmp
            buf << tmp
            ins = nil
          when "{";
          else
            ins << c
          end
        else
          if [" ", ".", ",", "-", "/", "\\", "\"", "'"].include? c
            tmp = self[ins, false].to_a[0]
            raise ins unless tmp
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
