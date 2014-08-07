#stuff to put in during polishing
def excess_stuff
	#if time permits: can run program with save file name to just jump straight to it 
	#credits and special thanks 
end

#Asks user a question and puts a > before user input  
def get_input (u_string)
	#puts u_string
	print "#{u_string}\n> "
	return gets.chomp
end

#Hand a question that needs only one response, asks question
#If question is ok, returns inputed value
def yn_confirm (ask_string)
	while true
		@u_input = get_input(ask_string)
		@yes_no = get_input("You wrote #{@u_input}, confirm? Y/N").downcase
		if (@yes_no == "y") or (@yes_no == "yes")
			break
		elsif (@yes_no == "n") or (@yes_no == "no")
			#returns 
		else
			print "Input error: "
		end
	end
	return @u_input
end

#Prompt to load or start  
def gamestart
	@dec = nil #so it has to input
	while ["l", "load" , "start", "s"].include?(@dec) != true do
		puts 
		#@dec = get_input("Would you like to (L)oad or (S)tart a game?").downcase
		@dec = "s" #/test
		if (@dec == "l") or (@dec == "load")
			l_load
			break
		elsif (@dec == "s") or (@dec == "start")
			s_start
			break
		else
			print "Input error: "
		end
	end
end

#Load up old save file, takes the selected file and puts it into key value pairs 
def l_load
	#puts "Skipping shit, testing! - Assume trying to open file 1" #/test
	puts "Loading game, please choose a save file by writing file number:"
	@saves = {}
	@i = 0
	#takes an empty array (@saves) and iterates through all save files in the folder
	#putting ones that end in .txt as value, with key the order it was put into array (@i) 
	Dir.new('.').each {|file| 
		if file.include?(".txt")
			@i += 1
			@saves[@i] = file
			@char_name = File.open(file, &:readline)
			puts "  * File #{@i} (#{file}) - Character #{@char_name[5..-1]}" #File Key Character Name 
			# INCLUDE: File.mtime(file).strftime("%B %d %Y,%l:%M%P") if ya want moddate, but kinda brokenish
	end	}
	#Infinite loop that can't end until recieves valid input 	
	while true
		print "> File " #user only needs to enter number
		@f_choice = gets.chomp.to_i
		#@f_choice = 1 #/test

		#if invalid input, redo
		unless @saves.include?(@f_choice) 
			puts "Input error! Input a valid file name!"
			redo
		end
		@load_f = get_input("Load File #{@f_choice}? Y/N").downcase
		#@load_f = "y" #/test
		if (@load_f == "y") or (@load_f == "yes")
			break
		elsif (@load_f == "n") or (@load_f == "no")
			puts "Ok, select a different file." 
		else
			puts "Input error!"
		end
	end
	$savefile = @saves[@f_choice]
	@savetxt = File.read($savefile) #.txt save data
	$savedata ={}
	#finds key which is all value before : and val which is between : and \n
	#puts key and value into array and crops save file data
	while @savetxt.include?("\n") do
		@l_key = @savetxt.index(":")
		@l_val = @savetxt.index("\n")
		$savedata[@savetxt[0..(@l_key-1)]] = @savetxt[(@l_key+1)..@l_val]
		@savetxt = @savetxt[@l_val+1..-1]
	end
	puts "Your character: "
	$savedata.each  {|key, val| puts "  #{key}:#{val}"}
	puts "Alright lets continue your RubyQuest adventure!"
end

#Start new rubyquest game, get: name, class, gender, stats
def s_start
	puts "Time to start your RubyQuest adventure!"
	##$char = yn_confirm("What would you like to name your character?")
	$char = "Ben" #/test
	puts "Ok, your character name is #{$char}!"
end

puts "Welcome to RubyQuest"#: The Search for Merlin's Gold"
gamestart
