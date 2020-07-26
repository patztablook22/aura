class Pipe

  @command
  @return
  @stdout

  def initialize
  end

  def command= str
    @command = str if @command.nil?
  end

  def go!
    IO.popen(@command, :err => [:child, :out]) do |io|
      @stdout = io.read
      io.close
      @return = $?.to_i
    end
  end

  def ok?
    @return == 0
  end

  def out
    @stdout
  end

end
