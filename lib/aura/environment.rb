class Environment

  attr_reader :conf, :errs, :aurs, :pkgs, :root, :redo

  @conf
  @errs
  @aurs
  @pkgs
  @root
  @todo
  @redo
  @init

  def conf= path
    return if @conf or !path or path.empty?
    @conf = File.expand_path path
  end

  def conf!

    return unless @conf
    parser = Parser.new @conf
    data = parser.data
    return unless data

    err = false

    data.each_pair do |key, val|

      assign = key + "="
      val = val[0] if val.class == Array

      begin
        send(assign, val)
      rescue
        Console << "unknown constant: #{key}"
        err = true
      end

    end

    raise if err

  end

  def errs= path
    return if @errs or !path or path.empty?
    @errs = File.expand_path path
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
    return if @aurs or !path or path.empty?
    @aurs  = File.expand_path path
    @aurs += "/" unless @aurs[-1] == "/"
  end

  def pkgs= path
    return if @pkgs or !path or path.empty?
    @pkgs  = File.expand_path path
    @pkgs += "/" unless @pkgs[-1] == "/"
  end

  def root= path
    return if @root or !path or path.empty?
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

  def tree?

    dirs = [
      @aurs,
      @pkgs,
      @root,
    ]

    fils = [
      @conf,
      @errs,
    ]

    return dirs.all? { |dir| File.directory? dir } \
    #   && fils.all? { |fil| File.file?      fil }

  end

end

$env = Environment.new
