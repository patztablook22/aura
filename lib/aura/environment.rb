class Environment

  attr_reader :aurs, :pkgs, :root, :todo, :redo

  @aurs
  @pkgs
  @root
  @todo
  @redo

  def init
    [aurs, pkgs, root].each do |path|
      FileUtils.mkdir_p(path) unless File.directory? path
    end
  end

  def aurs= path
    @aurs  = File.expand_path path
    @aurs += "/" unless @aurs[-1] == "/"
  end

  def pkgs= path
    @pkgs  = File.expand_path path
    @pkgs += "/" unless @pkgs[-1] == "/"
  end

  def root= path
    @root  = File.expand_path path
    @root += "/" unless @root[-1] == "/"
  end

  def todo= name
    @todo = name
  end

  def redo= bool
    @redo = bool if @redo.nil?
  end

end
