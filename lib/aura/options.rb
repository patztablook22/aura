OptionParser.new do |opt|

  opt.banner = "#$0 [options] package"

  opt.on("-h", "--help", "print this help") do |dir|
    puts opt
    exit
  end

  opt.on("-r", "--redo", "force install from zero") do
    $env.redo = true
  end

  opt.on("-e", "--errs [FILE]", "error log file") do |file|
    $env.errs = file unless file.nil? or file.empty?
  end

  opt.on("--aurs [DIR]", "dir with AUR files") do |dir|
    $env.aurs = dir unless dir.nil? or dir.empty?
  end

  opt.on("--pkgs [DIR]", "hostdir for packages") do |dir|
    $env.pkgs = dir unless dir.nil? or dir.empty?
  end

  opt.on("--root [DIR]", "target root directory") do |dir|
    $env.root = dir unless dir.nil? or dir.empty?
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
