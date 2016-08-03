module Rubii
  module Linux
    module XDoTool
      module KeyEvent
        attr_accessor :key
        def initialize key, driver=nil
          super driver
          @key = key
        end
        
        def perform driver = @driver, key = @key
          super driver
        end
      end
      
      class MouseMotionEvent < InputEvent
        include AxisEvent
        def initialize x=0, y=0, type = :rel, driver=nil
          super x,y,driver
          @type = type
        end
        
        def perform driver=@driver, x=@x, y=@y, z=@z, type=@type
          driver.mouse_motion type, x, y
        end
      end

      class MouseButtonEvent < InputEvent
        attr_accessor :button
        include AxisEvent
        def initialize button, x=nil, y=nil, driver=nil
          @button = button
          
          super x,y, driver
        end
        
        def perform driver=@driver, button=@button, x=@x, y=@y
          if x and y
            MouseMoveABS.new(x,y,driver).perform
          end
        end
      end  
      
      class MouseClick < MouseButtonEvent
        def perform driver=@driver, button = @button, x=@x,y=@y
          super
          driver.mouse_down button
          driver.mouse_up button
        end
      end
      
      class MouseButtonPress < MouseButtonEvent
        def perform driver=@driver, button = @button, x=@x,y=@y
          super
          driver.mouse_down button
        end
      end
      
      class MouseButtonRelease < MouseButtonEvent
        def perform driver=@driver, button = @button, x=@x,y=@y
          super
          driver.mouse_up button
        end
      end            
    
      class KeyPress < InputEvent
        include KeyEvent
        def perform driver = @driver, key = @key
          p [key, driver]
          driver.key_press key
        end
      end
      
      class KeyRelease < InputEvent
        include KeyEvent
        def perform driver = @driver, key = @key
          driver.key_release key
        end
      end
      
      class KeySend < InputEvent
        include KeyEvent
        def perform driver = @driver, key = @key
          driver.key_press key
          driver.key_release key
        end
      end
      
      class MouseMoveRel < MouseMotionEvent
        attr_reader :type
        
        def initialize x=0,y=0, driver=nil
          super x,y,:rel, driver
        end
        
        def perform driver=@driver, x=@x, y=@y, type=@type
          super driver, x,y,type
        end
      end
      
      class MouseMoveABS < MouseMotionEvent
        attr_reader :type
        def initialize x=0,y=0, driver=nil
          super x,y,:abs, driver
        end
        
        def perform driver=@driver, x=@x, y=@y
          super driver, x,y, type
        end
      end
      
      class SendText < InputEvent
        attr_reader :text
        def initialize text=nil, driver=nil
          @text = text
          super driver
        end
        
        def perform driver=@driver, text=@text
          driver.send_text text
        end
      end
      
      class AppLaunch < InputEvent
        def perform driver=@driver, path=@path
        
        end
      end
    end
  end
end
