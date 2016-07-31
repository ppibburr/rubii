module Rubii
  class InputEvent
    def initialize

    end

    def perform
      true
    end
  end

  NullEvent = InputEvent.new
  
class KeyEvent < InputEvent
    attr_reader :key
    def initialize key
      @key = key
    end

    def perform key = @key
      sendkey key
    end
  end

  module AxisEvent
    attr_accessor :x, :y
   
    def initialize x=nil, y=nil, *o
      @x,@y = x,y
      super *o
    end

    def perform x=@x, y=@y
      return unless x and y

      super()

      return true
    end
  end

  class TextInputEvent < InputEvent
    attr_accessor :text
    def perform text=@text
      return unless text
      sendtext text
    end
  end

  class DeviceEvent < InputEvent
    attr_reader :actions, :device
    def initialize device, actions=[[0,0,0]]
      @device  = device
      @actions = actions
    end

    def perform
      actions.each do |a|
        sendevent "#{device} a.join(" ")"
      end

      sendevent "#{device} 0 0 0"
    end
  end

  class MotionEvent < InputEvent
    include AxisEvent

    attr_reader :device

    def perform x = @x, y = @y
      return unless super

      sendevent "#{device} 2 0 #{x}"
      sendevent "#{device} 0 0 0"

      sendevent "#{device} 2 1 #{y}"
      sendevent "#{device} 0 0 0"
    end
  end


  class AppLaunchEvent < InputEvent
    def initialize app=nil
      @app = app
      super()
    end

    def perform app=@app
      return unless app

      launch(app)
    end
  end
end
