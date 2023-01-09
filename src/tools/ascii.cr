module MUD
	module ASCII
		extend self

		@@storage = {} of String => String

		def get(filename : String) : String
			@@storage[filename]
		end

		ColorCodes = {
			"{clear}" 		=> 0,

			"{black}" 		=> 30,
			"{red}" 		=> 31,
			"{green}" 		=> 32,
			"{yellow}" 		=> 33,
			"{blue}" 		=> 34,
			"{magenta}" 	=> 35,
			"{cyan}" 		=> 36,

			"{light_gray}" 		=> 37,
			"{dark_gray}" 		=> 90,
		    "{light_red}" 		=> 91,
		    "{light_green}" 	=> 92,
		    "{light_yellow}"	=> 93,
		    "{light_blue}" 		=> 94,
		    "{light_magenta}" 	=> 95,
		    "{light_cyan}" 		=> 96,
		    "{white}" 			=> 97
		}

		private def prepocess(string : String) : String
			# Color codes preproc
			ColorCodes.each do |k, v|
				string = string.sub(k, "\e[" + v.to_s + "m")
			end

			# Special codes preproc
			if string.byte_slice(0, 15) == "# random colors"
				string = string[17..string.size]

				io = IO::Memory.new

				string.each_char do |c|
					io << "\e[" + ColorCodes.values.sample.to_s + "m"
					io << c
					io << "\e[0m"
				end

				string = io.to_s
				io.close
			end

			string
		end

		def load()
			Dir.new("config/ascii").children.each do |a|
				if File.writable?("config/ascii/" + a)
					@@storage[a] = prepocess(File.read("config/ascii/" + a))
				end
			end
		end
	end
end