class Source

  @source
  @target

  @fileI
  @fileO

  def initialize(source, target)

    @source = source
    @target = File.expand_path(source.split("/")[-1], target)

    if source.start_with? /http(s)?:\/\//
      type = :net
    else
      type = :pkg
    end

    request type
    process

  end

  private

  def request type

    File.open(@target, 'w') do |file|
      case type
      when :net;
        file << requestNet
      when :pkg;
        file << requestPkg
      end
    end

  end

  def requestNet

    url = URI(@source)

    Net::HTTP.start(url.hostname) do |http|
      head = http.request_head(url)
      Console << [ :req, @source, head["content-length"] ]
    end

    URI.open(url).read

  end

  def requestPkg
    Console << [:req, @target]
    File.open(@source).read
  end

  def process

    extensions = []
    tmp = @target

    begin

      extension = File.extname(tmp)
      tmp = File.basename(tmp, ".*")
      
      valid = (!extension.empty? and extension =~ /[a-zA-Z]/)

      if valid
        extensions.push extension[1..-1]
      end

    end while valid

    if extensions.include? "tar"

      Console << [:tar, @target]

      command = String.new

      command << "tar -"
      command << "z" if extensions.index { |it| it =~ /.z/ }
      command << "xf "
      command << @target
      command << " -C "
      command << File.dirname(@target)

      pipe = Pipe.new
      pipe.command = command
      pipe.go!

    end
    
  end

  def log
    File.basename @target
  end

end
