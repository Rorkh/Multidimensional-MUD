require "colorize"

module MUD
	module Output
		extend self

		Tag = "[MUD] ".colorize.magenta.to_s
		DebugTag = "[DBG] ".colorize.red.to_s
		ErrorTag = "[ERROR] ".colorize.red.to_s

		def debug(s)
			puts DebugTag + s
		end

		def error(s)
			puts ErrorTag + s
		end

		def log(s)
			puts Tag + s
		end

		def blue(s)
			return s.colorize.blue.to_s
		end

		def green(s)
			return s.colorize.green.to_s
		end
	end
end