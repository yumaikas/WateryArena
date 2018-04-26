;; Room module

;; Each room has two layers

(local images (require "images"))
(local room_metatable {})


(defn room_metatable.update [self dt] 
	(each [i enemy (ipairs (self.enemies))]
		(+ i)))

(defn room_metatable.render [self]
	(let 
		[bottom-layer (. images "room-bottom.png")
		top-layer (. images "room-top.png") 
		draw love.graphics.draw]
		(draw (if self.is-low bottom-layer top-layer) 0 0 0 3 3)))

(fn [player] 
	(let [
			room {
				:enemies {}
				:enemy-spells {}
				:player-spells {}
				:player player
				:doors {}
				:is-low true
				:background-image nil
			}]
		(setmetatable room {:__index room_metatable} )
		room))
