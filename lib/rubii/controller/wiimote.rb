module Rubii
  module WiiMote
    class Controller < Rubii::Controller
      class Led < Rubii::Component
        def set i

        end
 
        def get
  
        end
 
        def blink rate=1
 
        end
      end

      class Buttons < Rubyii::Controller::Buttons
      end

      class Acc < XYZAxis
        def initialize controller, update_rate = -1
          super [2,48,100,1], [2,48,100,1], [2,48,100,1], controller, update_rate
        end
         
        def read
          @values = controller.state.acc || @values || [0,0,0]
          super
        end
      end

      class IR < XYAxis
        def initialize controller, update_rate = -1
          super [10,1070,0,1], [10,760,100,1], controller, update_rate
        end
        
        def read
          @values = controller.state.ir[0] || @values || [0,0,0]
          super
        end
      end

      class Nunchuk < XYZAxis
        def initialize controller, update_rate = -1
          super [2,48,100,1], [2,48,100,1], [2,48,100,1], controller, update_rate
        end
        
        def read
          @values = controller.state.nunchuk || @values || [0,0,0]
          super
        end
      end

      attr_reader :wiimote, :state
      def initialize rpt_mode = RPT_ACC | RPT_BUTTONS | REPORT_IR
        @wiimote = WiiMote.new()
        wiimote.rpt_mode = rpt_mode

        @buttons       = Buttons.new

        @axi[:acc]     = Acc.new self
        @axi[:ir]      = IR.new self
        @axi[:nunchuk] = Nunchuk.new self
      end

      def update
        wiimote.request_status
        @state = wiimote.get_state
      end
    end
  end
end
