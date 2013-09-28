#!/usr/bin/env rp5 --nojruby run

class Wave < Processing::App

  attr_accessor :width, :height, :interval, :speed

  class Ring

    def rotate(speed)
      @arc = (@arc + speed) % 360
    end

    def draw
      stroke  0, 0, 0
      no_fill
      ellipse @x, @y, @diameter, @diameter

      stroke  0, 0, 0
      fill    0, 0, 0
      ellipse @x + cos(radians @arc) * @radius,
              @y + sin(radians @arc) * @radius,
              @bulb,
              @bulb
    end

    def initialize(x, y, diameter)
      @x, @y, @diameter = x, y, diameter
      @radius = diameter / 2

      @bulb = diameter / 8
      @arc  = (x + y) / 2
    end
  end

  def setup
    size width, height

    @rings = (0..width).step(interval).flat_map do |x|
      (0..height).step(interval).map do |y|
        Ring.new x.to_f, y.to_f, (interval * 1.8)
      end
    end
  end

  def draw
    background 255, 255, 255

    @rings.each do |ring|
      ring.rotate speed
      ring.draw
    end
  end

  def initialize(options = {})
    options.each { |k,v| send "#{k}=", v }

    super
  end
end

Wave.new width:    800,
         height:   800,
         interval: 40.0,
         speed:    10
