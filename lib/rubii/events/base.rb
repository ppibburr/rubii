module Rubii
  class InputEvent
    attr_accessor :driver
    def initialize driver=nil
      @driver = driver
    end

    def perform driver=@driver, *o
      true
    end
  end

  NullEvent = InputEvent.new
  
  class KeyEvent < InputEvent
    attr_reader :key
    def initialize key, driver = nil
      @key = key
      super driver
    end

    def perform  driver=@driver, key = @key
      driver.sendkey key
    end
  end

  module AxisEvent
    attr_accessor :x, :y
   
    def initialize x=nil, y=nil, *o
      @x,@y = x,y
      super *o
    end

    def perform driver=@driver, x=@x, y=@y, *o
      return unless x and y

      super(driver)

      return true
    end
  end

  class TextInputEvent < InputEvent
    attr_accessor :text
    def perform driver=@driver, text=@text
      return unless text
      driver.sendtext text
    end
  end

  class DeviceEvent < InputEvent
    attr_reader :actions, :device
    def initialize device = "/dev/input/event3", actions=[[0,0,0]], *o
      @device  = device
      @actions = actions
      super *o
    end

    def perform driver=@driver
      actions.each do |a|
        driver.sendevent "#{device} #{a.join(" ")}"
      end

      driver.sendevent "#{device} 0 0 0"
    end
  end

  class MotionEvent < DeviceEvent
    include AxisEvent

    attr_reader :device

   def initialize device, sx=1,sy=1
     super device
     @sx, @sy = sx,sy
   end

    def perform driver=@driver, x = @x, y = @y, *o
      return unless super

      driver.sendevent "#{device} 2 0 #{x*@sx}"
      driver.sendevent "#{device} 0 0 0"

      driver.sendevent "#{device} 2 1 #{y*@sy}"
      driver.sendevent "#{device} 0 0 0"
    end
  end


  class AppLaunchEvent < InputEvent
    def initialize app=nil, *o
      @app = app
      super(*o)
    end

    def perform driver=@driver, app=@app
      return unless app

      driver.launch(app)
    end
  end
end
