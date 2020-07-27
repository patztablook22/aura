class Environment

  attr_reader :errs, :aurs, :pkgs, :root, :redo

  @errs
  @aurs
  @pkgs
  @root
  @todo
  @redo
  @init

  def errs= path
    return if @errs
    @errs  = File.expand_path path
  end

  def init= bool
    return if @init
    @init = bool
  end

  def init?
    @init
  end

  def init!
    [aurs, pkgs, root].each do |path|
      FileUtils.mkdir_p(path) unless File.directory? path
    end
  end

  def aurs= path
    return if @aurs
    @aurs  = File.expand_path path
    @aurs += "/" unless @aurs[-1] == "/"
  end

  def pkgs= path
    return if @path
    @pkgs  = File.expand_path path
    @pkgs += "/" unless @pkgs[-1] == "/"
  end

  def root= path
    return if @root
    @root  = File.expand_path path
    @root += "/" unless @root[-1] == "/"
  end

  def todo= name
    return if name.nil? or name.empty?
    @todo = @todo.to_a << name
  end

  def todo
    return @todo[0] if @todo.to_a.size == 1
    return false
  end

  def redo= bool
    return if @redo
    @redo = bool if @redo.nil?
  end

end

$env = Environment.new
