(local constants {
	:width 768
	:height 576
	:player_size 10
	})

(defn love.conf [t]
	(set t.window.title "Watery Arena")
	(set t.window.width constants.width)
	(set t.window.height constants.height))

constants