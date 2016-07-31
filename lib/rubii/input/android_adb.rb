module Rubii
  module AndroidADB
    module Input
      include Rubii::Input
    
      def tap x,y
      
      end

      def longtap x,y

      end

      def swipe x,y,x1,y1

      end

      def sendevent evt

      end

      def sendkey key

      end

      def sendtext txt

      end

      def launch app

      end
    end
  end
  
  module AndroidADB
    class InputDevice < InputDevice
      def initialize cfg = Rubii::Config[:android][:adb][:default]
        super
      end
    end
  end  
end
