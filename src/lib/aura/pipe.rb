class Pipe

  @command

  @return
  @stdout
  @stderr

  def initialize
  end

  def command= str
    return if @command
    @command = String.new
    @command << "set -e\n"
    @command << str
  end

  def go!
    @stdout, @stderr, @return = Open3.capture3 @command
    @return = @return.exitstatus
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
