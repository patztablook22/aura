class Pipe

  @command

  @return
  @stdout
  @stderr

  def initialize
  end

  def command= str
    @command = str if @command.nil?
  end

  def go!
    @stdout, @stderr, @return = Open3.capture3 @command
  end

  def ok?
    @return == 0
  end

  def out
    @stdout
  end

  def err
    @stderr
  end

end
