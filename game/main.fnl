;; Requires
(local room (require "room"))
(require "utils")


(local first-room (room {}))

(local state {
	:timer 5
	})


(defn love.draw []
	(: first-room :render))

(defn love.update [dt]
	(set state.timer (- state.timer dt))
	(when (< state.timer 0) 
		(set state.timer 5)
		(set first-room.is-low (not first-room.is-low))))


