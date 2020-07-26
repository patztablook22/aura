class Request

  @source
  @target

  @fileI
  @fileO

  def initialize(source, target)

    @source = source
    @target = File.expand_path(source.split("/")[-1], target)

    if source.start_with? /http(s)?:\/\//
      type = URI
    else
      type = File
    end

    request type
    process

  end

  def request type

    Console << [:req, @target]

    fileI = type.open(@source)
    File.open(@target, 'w') do |fileO|
      fileO << fileI.read
    end

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

      command  = "tar -"
      command += "z" if extensions.index { |it| it =~ /.z/ }
      command += "xf "
      command += @target
      command += " -C "
      command += File.dirname @target

      system command

    end
    
  end

  def log
    File.basename @target
  end

end
