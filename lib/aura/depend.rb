class Depend

  @package
  @@tries = [
    "/usr/bin",
    "/usr/lib",
    "/usr/lib32",
    "/usr/lib64",
  ]

  def self.init

    Console.log("dependency")

    @@tries.filter! do |try|
      if File.symlink? try and @@tries.include? File.readlink(try)
        false
      else
        true
      end
    end

  end
  
  def initialize pkg
    @package = pkg
  end

  def present?

    Console.log("dependency", @package)

    command = String.new
    command << "find "
    @@tries.each do |try|
      command << try << " "
    end
    command << "-iname \"*"
    command << @package << "*\""

    pipe = Pipe.new
    pipe.command = command
    pipe.go!

    !pipe.out.empty?

  end

end
