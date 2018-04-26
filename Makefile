%.lua : %.fnl
	fennel --compile $< > $@

compile: game/main.lua game/room.lua game/conf.lua game/images.lua game/utils.lua

play: compile
	lovec.exe game

clean: 
	rm game/*.lua