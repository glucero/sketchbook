(ns bouncing-ball.core
  (:use quil.core))

(def window {:width 256 :height 256})

(def position {:x (atom 128N) :y (atom 128N)}) ; start ball in the center
(def velocity {:x (atom 4N) :y (atom 6N)})

(defn draw []
  (let [x-vel     @(:x velocity)
        y-vel     @(:y velocity)                 ; move the ball accoring to
        x-pos     (swap! (:x position) + x-vel)  ; its current (x,y) velocity
        y-pos     (swap! (:y position) + y-vel)] ; each draw loop

    (background 0)              ; wipe the screen
    (fill 0 0 255)              ; use a blue ball
    (ellipse x-pos y-pos 50 50) ; draw the ball

    (if (or
          (< x-pos 25)                       ; each time the ball's position
          (> x-pos (- (:width window) 25)))  ; to a window edge is past the
      (swap! (:x velocity) * -1))            ; ball's radius, multiply its
                                             ; x or y velocity by -1
    (if (or                                  ; (reversing its direction)
          (< y-pos 25)
          (> y-pos (- (:height window) 25)))
      (swap! (:y velocity) * -1))))

(defn setup []
  (frame-rate 60)
  (background 0))

(defn -main []
  (quil.core/defsketch bouncing-ball
    :title "bouncing ball"
    :setup setup
    :draw  draw
    :size [(:width window) (:height window)]))
