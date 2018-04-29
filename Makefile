%.lua : %.fnl
	fennel --compile $< > $@

compile: game/main.lua game/room.lua game/conf.lua game/images.lua
compile: game/utils.lua game/player.lua game/state.lua game/timers.lua
compile: game/player-spells.lua

play: compile
	lovec.exe game

clean: 
	rm game/*.lua