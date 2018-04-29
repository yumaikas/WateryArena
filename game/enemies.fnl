(local utils (require "utils"))
(local conf (require "conf"))
(local state (require "state"))
(local timers (require "timers"))

(local enemies {})

(defn quadrant-of-point-in-screen [x y]
	(let [
		xmid (/ conf.width 2)
		ymid (/ conf.height 2)
		dxpos (> x xmid) 
		dypos (> y ymid)
		]
	(if
		(and dxpos dypos) 1
		(and (not dxpos) dypos) 2
		(and (not dxpos) (not dypos)) 3
		(and dxpos (not dypos)) 4)))

(defn enemies.square.get-target [enemy]
	(let
		[random love.math.random
		current-quad (quadrant-of-point-in-screen enemy.x enemy.y)
		target-quad (. (. current-quad :others) (random 3))
		xbase target-quad.x
		ybase target-quad.y
		angle (+ (* 90 (random)) target-quad.angle-offset)
		dist (* (/ conf.height 2) (random))
		x (+ xbase (* (math.cos angle) dist))
		y (+ ybase (* (math.sin angle) dist))]
		(set enemy.xt x)
		(set enemy.yt y)))

(defn enemies.init.square [enemy]
	(enemies.square.get-target enemy))

(defn enemies.square.update [enemy]
	(if (= enemy.state :moving) 
		(let [
			(dx dy) (utils.norm (- enemy.x enemy.xt) (- enemy.y enemy.yt))
			xn (+ dx enemy.x)
			yn (+ dy enemy.y)
			reached-target (utils.dist xn yn enemy.xt enemy.yt)
			] 
			(set enemy.x xn)
			(set enemy.y yn)
			(when reached-target 
				(set enemy.state :resting)

				))
		(= enemy.state :resting)
		(do 
			(print "foo"))
		)
	)

(defn enemies.create [type x y] 
(let [enemy { 
		:type type 
		:x x :y y 
		:xt 0 :yt 0
		:is-low (not state.player.is-low)
		:state "moving"
	}]
	;; Determines how long a rest will last
	(set enemy.rest-timer (timers.create 1.0 (fn [] 
		(set enemy.state "moving")
		(enemies.square.get-target enemy)
		)))
	(set enemy.dodge-timer (timers.create 0.25 (fn []
		(set enemy.is-low (not state.player.is-low))
		)))
	((. enemies.init :type enemy)) 
))


(local square-moves 
{
	1 {
		:x conf.width
		:y 0
		:angle-offset (math.rad 180)
		:others [2 3 4]
	}
	2 {
		:x conf.width
		:y 0
		:angle-offset (math.rad 270)
		:others [1 3 4]

	}
	3 {
		:x conf.width
		:y 0
		:angle-offset (math.rad 0)
		:others [1 2 4]
	}
	4 {
		:x conf.width
		:y 0
		:angle-offset (math.rad 90)
		:others [1 2 3]
	}
})