(require "utils")
(love.graphics.setDefaultFilter :linear :nearest)

(defn is-file [path]
	(= (. (love.filesystem.getInfo path) :type) :file))
(let [fs love.filesystem
	images {}
	files (fs.getDirectoryItems :assets)]

	(each [i file (ipairs files)]
		;; This is a comment
		(when (and (is-file (.. "assets/" file)) (string.ends file ".png"))
			(tset images file (love.graphics.newImage (.. "assets/" file)))))
	images)


