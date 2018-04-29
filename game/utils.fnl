(local conf (require "conf"))
(local utils {})
(defn string.ends  [str end]
	(or (= end '') 
		(= (string.sub str (- (# end))) end)))

(defn utils.withColor [rgba func]
	(let 
		[(_r _g _b _a) (love.graphics.getColor)]
		(love.graphics.setColor rgba)
		(func)
		(love.graphics.setColor _r _g _b _a)))

(defn utils.current [tbl] (. (. tbl :items) (. tbl :idx)))

(defn utils.dist [x y xt yt]
	(math.sqrt (^ (- x xt) 2) (^ (- y yt))))

(defn utils.norm [xv yv]
	(let [mag (utils.dist 0 0 xv yv)]
		(values (/ x mag) (/ y mag))))
utils