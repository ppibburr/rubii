require "rubii/events/linux"
require "rubii/config/linux"
require "rubii/controller/wiimote"


module Rubii
  module Linux
    def self.shell cmd
      p cmd
      system cmd
    end 
  
    module XDoTool
      class Input < Rubii::Input
        def key_press key
          Linux.shell "xdotool keydown #{key}"
        end
        
        def key_release key
          Linux.shell "xdotool keyup #{key}"
        end
        
        def mouse_motion type, x,y
          Linux.shell "xdotool mousemove_relative --sync -- #{x*-1} #{y*-1}"
        end
        
        def send_text text
        
        end
        
        def mouse_up  button
          Linux.shell "xdotool mouseup #{button}"
        end
        
        def mouse_down button
          Linux.shell "xdotool mousedown #{button}"
        end
      end
    end
  end
end

module Rubii
  module Linux
    module XDoTool
      class InputDevice < Rubii::InputDevice
      end
      
      class WiiMote < Rubii::Linux::XDoTool::InputDevice
        attr_reader :led, :buttons, :ir, :acc, :nunchuk
        def initialize cfg = Rubii::Linux::XDoTool::Config[:wiimote]
          super Rubii::Controller::WiiMote.new, Rubii::Linux::XDoTool::Input.new, cfg
          
          @led      = controller.components[:led]
          @acc      = controller.components[:acc]
          @ir       = controller.components[:ir]
          @buttons  = controller.components[:buttons]
          @nunchuk  = controller.components[:nunchuk]
        end
        
        def run i=0.111
          led.blink 1, 5, 0.22
            
          super
        end
      end
    end
  end
end
