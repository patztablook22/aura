OptionParser.new do |opt|

  opt.banner = "#$0 [options] package"

  opt.on("-h", "--help", "print this help") do
    puts opt
    exit
  end
 
  opt.on("-r", "--redo", "force install from zero") do
    $env.redo = true
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

  opt.on("--root [DIR]", "target root directory") do |path|
    $env.root = path
  end

  opt.on("--init", "(re)initialize aura's tree") do 
    $env.init = true
  end

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
