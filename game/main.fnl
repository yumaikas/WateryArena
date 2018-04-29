;; Requires
(local room (require "room"))
(local player (require "player"))
(local utils (require "utils"))
(local state (require "state"))


(local input-map {
	:w :up
	:a :left
	:d :right
	:s :down
})

(defn love.load []
	(love.mouse.setGrabbed true))

(defn love.draw []
	(room.render (utils.current state.rooms))
	(player.render state.player)
	)

(defn love.keypressed [key scancode isrepeat]
	(let [current-room (utils.current state.rooms)]
		(when (= scancode :space) (set current-room.is-low (not current-room.is-low)))
		(when (= scancode :escape) (love.event.quit))
	))

(defn love.update [dt]
	(player.update state.player dt)
	(room.update (utils.current state.rooms) dt)
	)
