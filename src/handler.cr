require "socket"

require "./mud/player_data"
require "./tools/output"

Players = Hash(TCPSocket, PlayerData).new

def handle_client(client)
  # First client connection
  welcome = "*----------------------------------*\n" \
            "--------Multidimensional MUD--------\n" \
            "*----------------------------------*"

  client.puts welcome 

  # Insert in players list
  if !Players.has_key?(client)
    Players[client] = PlayerData.new(client)
  end

  # Logging
  MUD::Output.debug "New client connected"

  # Handle loop
  loop do
    message = client.gets
    client.puts "You said: " + (message && message || "")
  end
end