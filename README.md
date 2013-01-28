# sketchbook
### a collection of images and animations

### requirements

    clojure   (http://clojure.org)
    leiningen (https://github.com/technomancy/leiningen)
    quil      (https://github.com/quil/quil)

### creating a sketch

    ./sketch 'name'

### launching a sketch

    cd ./sketch_name
    lein deps
    lein run

### creating an animation

this will advance the counter at the end of the default template draw function

    (next-animation-frame!)
    or
    (next-animation-frame! :next)

this will advance the counter and export the image to disk

    (next-animation-frame! :save)

use the makegif script to combine the group of images into a single animated gif

    ./make_gif project_name frames delay

##### click each picture to view its main source file

<a href="https://github.com/glucero/sketchbook/blob/master/plasma/src/plasma/core.clj">
<img src="https://raw.github.com/glucero/sketchbook/master/images/plasma.gif" /></a>
<a href="https://github.com/glucero/sketchbook/blob/master/bouncing_ball/src/bouncing_ball/core.clj">
<img src="https://raw.github.com/glucero/sketchbook/master/images/bouncing_ball.gif" /></a>
