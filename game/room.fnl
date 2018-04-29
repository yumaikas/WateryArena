(local player-spells (require "player-spells"))
;; Each room has two layers

(local images (require "images"))
;; Room module
(local room {})

(defn room.update [self dt] 
	(player-spells.update self.player-spells dt)

	)

(defn room.render [self]
	(let 
		[bottom-layer (. images "room-bottom.png")
		top-layer (. images "room-top.png") 
		draw love.graphics.draw]
		(draw (if self.is-low bottom-layer top-layer) 0 0 0 3 3)
		(player-spells.render self.player-spells self.is-low)
		))

room