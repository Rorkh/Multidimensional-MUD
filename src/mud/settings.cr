require "config"

module MUD
	module Settings
		extend self

		@@gmcp_enabled = false

		def init()
			config = Config.file("config/game.conf")
			@@gmcp_enabled = config.as_bool("gmcp")
		end

		def gmcp_enabled()
			@@gmcp_enabled
		end
	end
end