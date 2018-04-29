(local utils (require "utils"))

(local player-spells {})

(defn player-spells.spawn [x y xt yt radius speed is-low]
	(let 
		[angle (math.atan2 (- yt y) (- xt x))
		dx (math.cos angle)
		dy (math.sin angle)]
		{   :x x
			:y y 
			:dx dx 
			:dy dy 
			:r radius 
			:speed speed
			:life-time 20
			:is-low is-low
		}))

(defn player-spells.update [spells dt]
	(each [_ spell (pairs spells)]
		(set spell.life-time (- spell.life-time dt))
		(set spell.x (+ spell.x (* spell.dx spell.speed)))
		(set spell.y (+ spell.y (* spell.dy spell.speed)))
		)
	;; Filter out spells
	(for [i (# spells) 1 -1] 
		(when (< (. spells i :life-time) 0)
			(table.remove spells i)))
)

(defn mode-of-high-low [hl] (if hl :fill :line))
(defn color-of-high-low [hl] (if hl [1 0 0] [0 0 1]))

(defn player-spells.render [spells is-low]
	(each [_ spell (pairs spells)]
		(let 
			[circle love.graphics.circle
			xp (- spell.x (* spell.dx 10))
			yp (- spell.y (* spell.dy 10))
			rp (/ spell.r 2)
			hl (= spell.is-low is-low)]
			(utils.withColor (color-of-high-low hl) (fn []
				(circle (mode-of-high-low hl) spell.x spell.y spell.r)
				(circle (mode-of-high-low hl) xp yp rp)
				)))))



player-spells


