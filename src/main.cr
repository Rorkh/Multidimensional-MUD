require "socket"
require "config"

require "./tools/output"
require "./tools/ascii"

require "./handler"

def main()
  config = Config.file("config/launch.conf")

  ip = config.as_s("address")
  port = config.as_i64("port")

  address = MUD::Output.blue(ip + ":" + port.to_s)

  MUD::Output.log "Setting up at " + address
  MUD::ASCII.load

  puts MUD::ASCII.get "welcome"

  begin
    server = TCPServer.new(ip, port)

    message = MUD::Output.green("Successfully started\n")
    MUD::Output.log message

    loop do
      if client = server.accept?
        spawn handle_client(client)
      else
        break
      end
    end
  rescue
    MUD::Output.error "Can't start server"
  end
end

main()