module BlinkCi
  class Blink
    PatternLine = Struct.new(:time, :color)

    def initialize
      @colors = {
        blue:   [ 0   , 0   , 255 ],
        red:    [ 255 , 0   , 0   ],
        white:  [ 255 , 255 , 255 ],
        green:  [ 0   , 250 , 0   ],
        orange: [ 245 , 150 , 0   ],
        black:  [ 0   , 0   , 0   ]
      }
    end

    def show_color(color)
      c = @colors[color]
      Blink1.open do |b|
        b.off
        b.set_rgb(*c)
      end
    end

    # shows a pattern
    # pattern should be PatternLine objects
    def show_pattern(pattern)
      raise if pattern.length > 10

      c = @colors

      Blink1.open do |b|
        pattern.each_with_index do |pattern_line, i|
          time = pattern_line.time
          color = c[pattern_line.color]

          b.write_pattern_line(time, *color, i)
        end

        # reset other pattern lines (necessary???)
        (pattern.length..10).each do |i|
          b.write_pattern_line(0, *c[:black], i)
        end

        b.play(0)
      end
    end

    def building!(failure)
      pattern = [
        PatternLine.new(1000, :blue),
        PatternLine.new(1000, :blue)
      ]

      if failure
        pattern << PatternLine.new(1000, :red)
      else
        pattern << PatternLine.new(1000, :green)
      end

      show_pattern(pattern)
    end

    def success!
      show_color(:green)
    end

    def failure!
      show_color(:red)
    end

    def switch_off!
      show_color(:black)
    end

    def warning!
      show_color(:orange)
    end
  end
end
