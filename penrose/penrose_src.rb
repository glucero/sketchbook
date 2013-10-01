# Example Output: http://i.imgur.com/7Mimi.jpg

require 'cairo'
require 'complex'

X, Y = 1200, 1200
@color_1 = [0.4, 0.4, 1.0]
@color_2 = [0.7, 0.7, 0.7]
@color_3 = [0.2, 0.2, 0.2]
GOLDEN_RATIO = (1 + Math.sqrt(5)) / 2

surface = Cairo::ImageSurface.new(:argb32, X, Y)
@cr = Cairo::Context.new(surface)
@cr.translate(X / 2, Y / 2)
radius = 1.2 * Math.sqrt((X / 2) ** 2 + (Y / 2) ** 2)
@cr.scale(radius, radius)

def divide(triangles)
  result = []
  triangles.each do |clr, a, b, c|
    if clr.eql? @color_1
      p = a + (b - a) / GOLDEN_RATIO
      result.push [@color_1, c, p, b], [@color_2, p, c, a]
    else
      q = b + (a - b) / GOLDEN_RATIO
      r = b + (c - b) / GOLDEN_RATIO
      result.push [@color_2, r, c, a], [@color_2, q, r, b], [@color_1, r, q, a]
    end
  end
  result
end

def draw(shapes, color)
  shapes.each do |clr, a, b, c|
    if color.eql? clr or color.eql? @color_3
      @cr.move_to(a.real, a.imag)
      @cr.line_to(b.real, b.imag)
      @cr.line_to(c.real, c.imag)
      @cr.close_path unless color.eql? @color_3
    end
    @cr.set_source_rgb(*color)
    color.eql?(@color_3)? @cr.stroke : @cr.fill
  end
end

triangles = 10.times.map do |num|
  rect = lambda { |val| (1 + 0.to_c) * Math.exp(Complex(0, (2 * num + val) * Math::PI / 10)) }
  b, c = rect.call(-1), rect.call(1)
  b, c = c, b if num.even?

  [@color_1, 0.to_c, b, c]
end
8.times { triangles = divide(triangles) }
outlines = triangles.map { |tri| [tri[0], tri[3], tri[1], tri[2]] }

color, a, b, c = triangles.first
@cr.set_line_width((b - a).abs / 10.0)
@cr.set_line_join(Cairo::LineJoin::ROUND)

draw(triangles, @color_1)
draw(triangles, @color_2)
draw(outlines, @color_3)

surface.write_to_png('penrose.png')
