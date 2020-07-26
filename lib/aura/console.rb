module Console

  include Colors

  @@size = 0
  @@data = {
    :message => "",
    :content => [],
    :symbols => [],
  }

  def self.log *args

    message = ""
    content = []
    symbols = []

    message = args.shift

    args.each_with_index do |arg, i|
      if arg.class == Symbol
        symbols << arg
      else
        content << arg
      end
    end


    @@data[:message] = message
    @@data[:content] = content
    @@data[:symbols] = symbols

    render

  end

  def self.end ok = true
    return if @@size == 0
    @@size = 0
    puts
  end

  def self.err *args

    self.end false

    $stderr.puts
    $stderr.puts args
    $stderr.puts

  end

  def self.hr
    self.end
    puts "─" * width
  end

  private

  def self.render
    w = width

    buf = String.new
    buf << @@data[:message].upcase

    content = @@data[:content]

    main = content.shift
    meta = content.shift

    unless main.nil?
      buf << " [" << resize(w - buf.size - 5, main) << "]"
    end

    buf << " "

    erase
    @@size = buf.length
    print buf
  end

  def self.erase
    print "\b" * @@size + " " * @@size + "\b" * @@size
  end

  def self.resize(len, str)

    len -= 1

    unless str.length > len
      str
    else
      half = len / 2
      str[0..half - 2] + "..." + str[-half..-1]
    end

  end

  def self.width
    pipe = Pipe.new
    pipe.command = "tput cols"
    pipe.go!
    pipe.out.to_i
  end

end
