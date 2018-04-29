(local timers {})

(defn timers.create [time timeout]
{
	:reset-time time
	:time time
	:timeout timeout
	:running false
	:reset (fn [self] 
		(set self.time self.reset-time)
		(set self.running true))
	:update (fn [self dt]
		(when self.running 
			(set self.time (- self.time dt)) 
			(when (< self.time 0) 
				(set self.running false)
				(self.timeout))))
})

(defn timers.startFrom [time timeout]
	(let [timer (timers.create time timeout)]
		(set timer.running true)
		timer))
timers