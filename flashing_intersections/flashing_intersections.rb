#!/usr/bin/env rp5 --nojruby run

class Grid < Processing::App

  attr_accessor :width, :height, :interval

  class Line

    def dot_every(interval)
      stroke 255, 255, 255, 255
      fill 255, 255, 255, 255
      (0..@distance).step(interval).each do |y|
        ellipse @x, y, 5, interval / 8
      end
    end

    def horizontal
      stroke 230, 230, 230, 150
      stroke_weight 8
      line @x, @y, @x, @y + @distance
    end

    def vertical
      stroke 230, 230, 230, 150
      stroke_weight 8
      line @x, @y, @x + @distance, @y
    end

    def initialize(x, y, distance)
      @x, @y = x, y
      @distance = distance
    end
  end

  def setup
    size width, height

    @horizontal = (0..height).step(interval).map { |x| Line.new(x, 0, height) }
    @vertical = (0..width).step(interval).map { |y| Line.new(0, y, width) }
  end

  def draw
    background 25, 25, 25

    @vertical.each &:vertical
    @horizontal.each &:horizontal
    @horizontal.each { |line| line.dot_every @interval }
  end

  def initialize(options)
    options.each { |k,v| send "#{k}=", v }

    super
  end
end

Grid.new width:    800,
         height:   800,
         interval: 40.0

