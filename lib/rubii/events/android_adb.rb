module Rubii
  module AndroidADB
    class TapEvent < InputEvent
      include AxisEvent

      def perform driver=@driver, x=@x, y=@y
        return unless super
        driver.tap(x, y)
      end
    end

    class LongTapEvent < TapEvent
      def tap(driver=@driver, x=@x, y=@y)
        driver.longtap x,y
      end
    end

    class SwipeEvent < InputEvent
      include AxisEvent
      attr_accessor :x1, y1
      def initialize x=nil, y=nil, x1=nil, y1=nil, *o
        super x, y, *o
        @x1,@y1 = x1,y1
      end

      def perform , driver=@driver, x=@x, y=@y, x1=@x1, y1=@y1
        return unless super and (x1 and y1)

        driver.sendswipe x,y,x1,y1
      end
    end

    class RollEvent < InputEvent
      def perform driver=@driver, x=@x, y=@y
        return unless super

        driver.sendroll x, y
      end
    end
  end
end
