class Pipe

  @command

  def initialize
  end

  def command= str
    @command = str if @command.nil?
  end

  def go!

    system @command

  end

end
