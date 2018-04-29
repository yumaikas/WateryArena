(local conf (require "conf"))
{
	:timer 5
	:player {
		:x (/ conf.width 2)
		:y (/ conf.height 2)
		:r conf.player_size
		:speed 200
		:can-shoot true
	}

	:timers {}

	:rooms {
		:idx 1
		:items [{
			:enemies {}
			:enemy-spells {}
			:player-spells {}
			:doors {}
			:is-low true
			:background-image nil
		}]
	}
}