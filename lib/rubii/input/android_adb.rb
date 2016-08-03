require "rubii/config/android_adb"
require "rubii/controller/wiimote"
require 'open3'
module Rubii
  module AndroidADB
    class Input < Rubii::Input
      def initialize
        @pipe, @out, @err = Open3.popen3("adb shell")
      end
      
      def shell c
        @pipe.puts c
        until @out.gets; end
      end
    
      def tap x,y
        shell "input tap #{x} #{y}"
      end

      def longtap x,y
        shell "input tap --long #{x} #{y}"
      end

      def swipe x,y,x1,y1
        shell "input swipe #{x} #{y} #{x1} #{y1}"
      end

      def sendevent evt
        shell "sendevent #{evt}"
      end

      def sendkey key
        shell "input keyevent #{key}"
      end

      def sendtext txt

      end

      def launch app

      end
    end
  end
  
  module AndroidADB
    class WiiMote < InputDevice
      def initialize cfg = Rubii::AndroidADB::Config[:wiimote]
        super Rubii::Controller::WiiMote.new, Rubii::AndroidADB::Input.new, cfg
        driver.shell "sendevent /dev/input/event3 2 0 -3000"
        driver.shell "sendevent /dev/input/event3 0 0 0"
        driver.shell "sendevent /dev/input/event3 2 1 -3000"
        driver.shell "sendevent /dev/input/event3 0 0 0"
        
        controller.components[:led].blink 1,5, 0.2
      end
    end
  end  
end
