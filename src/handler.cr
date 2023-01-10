require "socket"
require "config"

require "./mud/player_data"
require "./tools/output"

require "./mud/settings"

Players = Hash(TCPSocket, PlayerData).new

def handle_client(client)
  # Logging
  MUD::Output.debug "New client connected"
  
  if MUD::Settings.gmcp_enabled
    # IAC WILL GMCP
    client.write Bytes[255, 251, 201]
  end

  client.puts MUD::ASCII.get "welcome"

  # Insert in players list
  if !Players.has_key?(client)
    Players[client] = PlayerData.new(client)
  end

  # Handle loop
  loop do
    message = client.gets

    puts "Received"
    puts (message && message.inspect || "") + "\n"
    puts "Receive end"

    client.puts "You said: " + (message && message || "")
  end
end