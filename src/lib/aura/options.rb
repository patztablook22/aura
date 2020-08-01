OptionParser.new do |opt|

  opt.banner = "aura [options] package"

  opt.on("-h", "--help", "print this help") do
    puts opt
    exit
  end

  opt.on("-v", "--verbose", "verbose mode") do
    $env.verb = true
  end
 
  opt.on("-r", "--redo", "rebuild the package") do
    $env.redo = true
  end

  opt.on("-s", "--skip [DEP]", "skip given dependency check") do |pkg|
    $env.skip! pkg
  end

  opt.on("-k", "--keep", "don't dump the tmp root") do
    $env.keep = true
  end

  opt.on("-c", "--conf [FILE]", "config file") do |path|
    $env.conf = path
  end

  opt.on("-e", "--errs [FILE]", "error log file") do |path|
    $env.errs = path
  end

  opt.on("--aurs [DIR]", "dir with AUR files") do |path|
    $env.aurs = path
  end

  opt.on("--pkgs [DIR]", "hostdir for packages") do |path|
    $env.pkgs = path
  end

  opt.on("--root [DIR]", "tmp root directory") do |path|
    $env.root = path
  end

=begin
  opt.on("--init", "initialize aura's tree") do 
    $env.init = true
  end
=end

  begin
    opt.parse!
  rescue
    $stderr.puts "invalid option(s)"
    exit 1
  end

  ARGV.each do |arg|
    $env.todo = arg
  end

end
