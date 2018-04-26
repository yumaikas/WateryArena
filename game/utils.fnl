(defn string.ends  [str end]
	(or (= end '') 
		(= (string.sub str (- (# end))) end)))