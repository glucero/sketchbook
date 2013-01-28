(ns plasma.core
  (:use quil.core))

(def window {:width, 256, :height, 256})

(def animation-frame (atom 0N))
(defn next-animation-frame!
  ([] (swap! animation-frame inc))
  ([save]
    (if (= save :save)
      (save-frame (str "/tmp/plasma/" @animation-frame ".png")))
    (swap! animation-frame inc)))

(def plasma-map
  (for [x (range (:width window)) ]
  (for [y (range (:height window))]
  (let [waves [(/ (double x) 16.0)      ; wave 1
               (/ (double y) 32.0)      ; wave 2
               (/ (Math/sqrt (double (+ ; wave 3
                                       (* (/ (- x (:width  window) 2.0))
                                          (/ (- x (:width  window) 2.0)))
                                       (* (/ (- y (:height window) 2.0))
                                          (/ (- y (:height window) 2.0)))))) 32.0)
               (/ (Math/sqrt (double (+ ; wave 4
                                       (* x x)
                                       (* y y)))) 32.0)]]
    (/ (apply + ; the average of all waves
         (map
           (fn [v] (+ 128.0 (* 128.0 (Math/sin v))))
           waves))
       (count waves))))))

(def plasma-palette
  (for [i (range 256)] ; create a 256 color rgb palette with zero discontinuities
    (map               ; so we can cycle through it from end to end
      (fn [v] (+ 128.0 (* 128.0 (Math/sin (* Math/PI (/ i v))))))
      (vector 32.0 64.0 128.0)))) ; [red green blue]

(defn draw []
  (doseq [x (range (:width window))]  ; draw the monochome plasma map and
  (doseq [y (range (:height window))] ; use each pixel value as the index
  (let   [index   (+ @animation-frame ; of the rgb palette
                    (nth (nth plasma-map y) x))
          [r g b] (nth plasma-palette
                    (mod index 256))]
    (stroke r g b)
    (point x y))))

  (next-animation-frame!))         ; advance animation frame without saving
  ; (next-animation-frame! :save))   ; animate and save each frame to /tmp

(defn setup []
  (frame-rate 60)
  (background 0))

(defn -main []
  (quil.core/defsketch plasma
    :title "plasma"
    :setup setup
    :draw  draw
    :size [(:width window) (:height window)]))

