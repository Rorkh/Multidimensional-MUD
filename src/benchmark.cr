require "benchmark"

io = IO::Memory.new

# ---------------
# Print test
# ---------------

require "colorize"

Tag = "[MUD] ".colorize.magenta.to_s

ip = "localhost"
port = 1000

address = (ip + ":" + port.to_s).colorize.blue.to_s

Benchmark.ips do |x|
  x.report("direct IO") do
    io << Tag << "Setting up at " + address
    io.clear
  end

  x.report("no direct IO") do
    io << Tag << "Setting up at " << address
    io.clear
  end
end