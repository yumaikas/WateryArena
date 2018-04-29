(local conf (require "conf"))
(local state (require "state"))
(local utils (require "utils"))
(local timers (require "timers"))
(local player-spells (require "player-spells"))

(local player {})
(defn player.render [self] 
	(utils.withColor [0.5 1 0.5]
		(fn [] (love.graphics.circle :fill self.x self.y, self.r))
		))

(defn player.update [self dt]
	(let 
		[key-down love.keyboard.isScancodeDown 
		is-clicked (fn [] (love.mouse.isDown 1))
		player state.player
		is-low (. (utils.current state.rooms) :is-low)
		]
		(: state.timers.player_shot :update dt)

		(when (key-down :w) (set player.y (- player.y (* dt player.speed))))
		(when (key-down :s) (set player.y (+ player.y (* dt player.speed))))
		(when (key-down :a) (set player.x (- player.x (* dt player.speed))))
		(when (key-down :d) (set player.x (+ player.x (* dt player.speed)))) 
		(when (and (is-clicked) player.can-shoot) 
			(let [
				xm (love.mouse.getX)
				ym (love.mouse.getY)
				spell (player-spells.spawn player.x player.y xm ym 5 10 is-low)
				room (utils.current state.rooms)
				] 
				(table.insert room.player-spells spell)
				(set player.can-shoot false)
				(: state.timers.player_shot :reset)
			)
		)
	))

(set state.timers.player_shot 
	(timers.create 0.3 (fn [] (set state.player.can-shoot true))))
(set state.timers.player_shot.running true)

player