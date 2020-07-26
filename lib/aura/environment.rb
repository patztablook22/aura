class Environment

  attr_reader :test, :temp, :todo, :redo

  @test
  @temp
  @todo
  @redo

  def cd?
    if File.directory? test+todo
      Dir.chdir test+todo
      true
    else
      false
    end
  end

  def test= path
    @test  = File.expand_path path
    @test += "/" unless @test[-1] == "/"
  end

  def temp= path
    @temp  = File.expand_path path
    @temp += "/" unless @temp[-1] == "/"
  end

  def todo= name
    @todo = name
  end

  def redo= bool
    @redo = bool if @redo.nil?
  end

end
